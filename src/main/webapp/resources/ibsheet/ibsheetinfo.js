var gJson = {Data: [[]]};

/*
 * IBSheet를 생성(호출 위치에서 동적 생성)
 */
function createIBSheet(sheetid, width, height, locale) {
    var div_str = "";

    if (!locale) locale = "";

    Grids.Locale = locale;

    div_str += "<div id='DIV_" + sheetid + "' style='width:" + width + ";height:" + height + ";'>";
    div_str += "<script> IBSheet('<ibsheet Sync=\"1\" Data_Sync=\"0\"> </ibsheet>',\"DIV_" + sheetid + "\", \"" + sheetid + "\"); </script>";
    div_str += "</div>\n";

    //<![CDATA[
    document.write(div_str);
    //]]>
}

/*
 * IBSheet를 생성 (특정 div 하위로 넣는 경우에 사용)
 */
function createIBSheet2(obj, sheetid, width, height, locale) {
    // locale 처리
    Grids.Locale = locale ? locale : "";

    if (typeof obj === "string") {
        obj = document.getElementById(obj);
    }

    if (obj && typeof obj === "object") {
        // width, height 적용
        obj.style.width = width;
        obj.style.height = height;

        IBSheet('<ibsheet Sync=\"1\" Data_Sync=\"0\"> </ibsheet>', obj.id, sheetid);
    } else {
        throw "[createIBSheet2] IBSheet container is null.";
    }
}

/* MergeSheet 속성에 설정 값 */
var msNone            = 0, // 머지 없음
    msAll             = 1, // 전부 머지 가능
    msPrevColumnMerge = 2, // 앞 컬럼이 머지 된 경우 해당 행 안에서 머지 가능
    msFixedMerge      = 3, // 단위데이터행 구조에서의 고정 셀 병합 기능
    msBaseColumnMerge = 4, // 기준 컬럼 머지 영역 범위 내에서의 머지 기능
    msHeaderOnly      = 5; // 해더만 머지

/* BasicImeMode 속성 설정 값 */
var imeAuto = 0; // 마지막 상태를 그대로 사용
var imeHan  = 1; // 기본 상태를 한글 입력 상태로 함
var imeEng  = 2; // 기본 상태를 영문 입력 상태로 함

/* SizeMode 속성 설정 값 */
var sizeAuto         = 0; // 설정한 높이, 너비 그대로 사용
var sizeNoVScroll    = 1; // 높이를 스크롤 없이 자동 설정
var sizeNoHScroll    = 2; // 너비를 스크롤 없이 자동 설정
var sizeNoBothScroll = 3; // 높이, 너비 모두 스크롤 없이 자동 설정
var sizeAdvancedAuto = 4; //설정한 높이 이전까지 스크롤 없이 높이 자동 설정

/* SearchMode 속성 설정 값 */
var smGeneral       = 0, // 일반 조회
    smClientPaging  = 1, // 클라이언트 페이징 조회
    smLazyLoad      = 2, // Lazy Load 조회
    smServerPaging  = 3, // 실시간 서버 페이징 조회 (Scroll 방식)
    smServerPaging2 = 4; // 실시간 서버 페이징 조회 (Page Index 방식)

/* SumPosition 속성 설정 값 */
var posTop    = 0; // 상단 고정 위치
var posBottom = 1; // 하단 고정 위치

/* VScrollMode 속성 설정 값 */
var vsAuto   = 0; // 자동 생성
var vsFixed = 1; // 고정 생성

/*
    FormQueryString 관련 함수 정의
*/
/* FormQueryString과 FormQueryStringEnc함수에서 필수입력 체크시 메시지로 사용한다.-3.4.0.50 */
var IBS_MSG_REQUIRED = "은(는) 필수입력 항목입니다.";

/**
 * 에러메시지를 표시한다. IBS_ShowErrMsg 대신 이 함수를 사용해야 한다.
 * @param   : sMsg      - 메시지
 * @return  : 없음
 * @version : 3.4.0.50
 * @sample
 *  IBS_ShowErrMsg("에러가 발생했습니다.");
 */
function IBS_ShowErrMsg(sMsg) {
    return alert("[IBSheetInfo.js]\n" + sMsg);
}

function IBS_getName(obj) {
    if (obj.name != "") {
        return obj.name;
    } else if (obj.id != "") {
        return obj.id;
    } else {
        return "";
    }
}

function IBS_RequiredChk(obj) {
    return (obj.getAttribute("required") != null);
}

/**
 * Form오브젝트 안에 있는 컨트롤을 QueryString으로 구성한다. 이때, 한글은 인코딩하지 않는다.
 * @param   : form          - 필수,html의 Form 오브젝트 Name
 * @param   : checkRequired - 선택,필수입력 체크 여부(true,false)
 * @return  : String        - Form오브젝트 안에 Control을 QueryString으로 구성한 문자열
 *            undefined     - checkRequired인자가 true이고, 필수입력에 걸린경우 return 값
 * @version : 1.0.0.0,
 *            3.4.0.50(checkRequired 인자 추가)
 * @sample1
 *  var sCondParam=FormQueryString(document.frmSearch); //결과:"txtname=이경희&rdoYn=1&sltMoney=원화";
 * @sample2
 *  <input type="text" name="txtName" required="이름">        //필수 입력 항목이면 required="이름" 를 설정한다.
 *  var sCondParam = FormQueryString(document.mainForm, true);//필수입력까지 체크하며, 필수입력에 걸리면 리턴값은 null
 *  if (sCondParam==null) return;
 */
function FormQueryString(form, checkRequired) {
    if (typeof form != "object" || form.tagName != "FORM") {
        IBS_ShowErrMsg("FormQueryString 함수의 인자는 FORM 태그가 아닙니다.");
        return "";
    }

    if (checkRequired == null) checkRequired = false;

    var name = new Array(form.elements.length);
    var value = new Array(form.elements.length);
    var j = 0;
    var plain_text = "";

    //사용가능한 컨트롤을 배열로 생성한다.
    len = form.elements.length;
    for (i = 0; i < len; i++) {
        var prev_j = j;
        switch (form.elements[i].type) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "radio":
            case "checkbox":
                if (form.elements[i].checked == true) {
                    name[j] = IBS_getName(form.elements[i]);
                    value[j] = form.elements[i].value;
                    j++;
                }
                break;
            case "select-one":
                name[j] = IBS_getName(form.elements[i]);
                var ind = form.elements[i].selectedIndex;
                if (ind >= 0) {

                    value[j] = form.elements[i].options[ind].value;

                } else {
                    value[j] = "";
                }
                j++;
                break;
            case "select-multiple":
                name[j] = IBS_getName(form.elements[i]);
                var llen = form.elements[i].length;
                var increased = 0;
                for (k = 0; k < llen; k++) {
                    if (form.elements[i].options[k].selected) {
                        name[j] = IBS_getName(form.elements[i]);
                        value[j] = form.elements[i].options[k].value;

                        j++;
                        increased++;
                    }
                }
                if (increased > 0) {
                    j--;
                } else {
                    value[j] = "";
                }
                j++;
                break;
            default:
                name[j] = IBS_getName(form.elements[i]);
                value[j] = form.elements[i].value;
                j++;
        }

        if (checkRequired) {
            //html 컨트롤 태그에 required속성을 설정하면 필수입력을 확인할 수 있다.
            //<input type="text" name="txtName" required="이름">

            if (IBS_RequiredChk(form.elements[i]) && prev_j != j && value[prev_j] == "") {

                if (form.elements[i].getAttribute("required") == null ||
                    form.elements[i].getAttribute("required") == ""
                ) {
                    alert('"' + IBS_getName(form.elements[i]) + '"' + IBS_MSG_REQUIRED);
                } else {

                    alert('"' + form.elements[i].getAttribute("required") + '"' + IBS_MSG_REQUIRED);
                }
                //컨트롤이 숨겨져 있을수도 있으므로 에러 감싼다.
                try {
                    form.elements[i].focus();
                } catch (ee) {;
                }

                return;
            }
        }
    }
    //QueryString을 조합한다.
    for (i = 0; i < j; i++) {
        if (name[i] != '') plain_text += name[i] + "=" + value[i] + "&";
    }

    //마지막에 &를 없애기 위함
    if (plain_text != "") plain_text = plain_text.substr(0, plain_text.length - 1);

    return plain_text;
}

/**
 * Form오브젝트 안에 있는 컨트롤을 QueryString으로 구성한다. 이때, 한글은 인코딩한다.
 * @param   : form          - 필수,html의 Form 오브젝트 Name
 * @param   : Sheet         - 필수,IBheet의 Object id
 * @param   : checkRequired - 선택,필수입력 체크 여부(true,false)
 * @return  : String        - Form오브젝트 안에 Control을 QueryString으로 구성한 문자열
 *            undefined     - checkRequired인자가 true이고, 필수입력에 걸린경우 return 값
 * @version : 1.0.0.0,
 *            3.4.0.50(checkRequired 인자 추가)
 * @sample1
 *  var sCondParam=FormQueryStringEnc(document.frmSearch, mySheet1);
 *  원본:"txtname=이경희&rdoYn=1&sltMoney=원화";
 *  결과:"txtname=%C0%CC%B0%E6%C8%F1&rdoYn=1&sltMoney=%BF%F8%C8%AD";                //UTF16인 경우
 *  결과:"txtname=%EC%9D%B4%EA%B2%BD%ED%9D%AC&rdoYn=1&sltMoney=%EC%9B%90%ED%99%94"; //UTF8인 경우
 * @sample2
 *  <input type="text" name="txtName" required="이름">                    //필수 입력 항목이면 required="이름" 를 설정한다.
 *  var sCondParam = FormQueryStringEnc(document.mainForm, mySheet, true);//필수입력까지 체크하며, 필수입력에 걸리면 리턴값은 null
 *  if (sCondParam==null) return;
 */
function FormQueryStringEnc(form, checkRequired) {
    if (typeof form != "object" || form.tagName != "FORM") {
        IBS_ShowErrMsg("FormQueryStringEnc 함수의 form 인자는 FORM 태그가 아닙니다.");
        return "";
    }


    if (checkRequired == null) checkRequired = false;

    var name = new Array(form.elements.length);
    var value = new Array(form.elements.length);
    var j = 0;
    var plain_text = "";

    //사용가능한 컨트롤을 배열로 생성한다.
    len = form.elements.length;
    for (i = 0; i < len; i++) {
        var prev_j = j;
        switch (form.elements[i].type) {
            case "button":
            case "reset":
            case "submit":
                break;
            case "radio":
            case "checkbox":
                if (form.elements[i].checked == true) {
                    name[j] = IBS_getName(form.elements[i]);
                    value[j] = form.elements[i].value;
                    j++;
                }
                break;
            case "select-one":
                name[j] = IBS_getName(form.elements[i]);
                var ind = form.elements[i].selectedIndex;
                if (ind >= 0) {

                    value[j] = form.elements[i].options[ind].value;

                } else {
                    value[j] = "";
                }
                j++;
                break;
            case "select-multiple":
                name[j] = IBS_getName(form.elements[i]);
                var llen = form.elements[i].length;
                var increased = 0;
                for (k = 0; k < llen; k++) {
                    if (form.elements[i].options[k].selected) {
                        name[j] = IBS_getName(form.elements[i]);

                        value[j] = form.elements[i].options[k].value;

                        j++;
                        increased++;
                    }
                }
                if (increased > 0) {
                    j--;
                } else {
                    value[j] = "";
                }
                j++;
                break;
            default:

                name[j] = IBS_getName(form.elements[i]);
                value[j] = form.elements[i].value;
                j++;
        }

        if (checkRequired) {
            //html 컨트롤 태그에 required속성을 설정하면 필수입력을 확인할 수 있다.
            //<input type="text" name="txtName" required="이름">
            if (IBS_RequiredChk(form.elements[i]) && prev_j != j && value[prev_j] == "") {
                if (form.elements[i].getAttribute("required") == "") {
                    alert('"' + IBS_getName(form.elements[i]) + '"' + IBS_MSG_REQUIRED);
                } else {
                    alert('"' + form.elements[i].getAttribute("required") + '"' + IBS_MSG_REQUIRED);
                }
                //컨트롤이 숨겨져 있을수도 있으므로 에러 감싼다.
                try {
                    form.elements[i].focus();
                } catch (ee) {;
                }

                return;
            }
        }
    }

    //QueryString을 조합한다.
    for (i = 0; i < j; i++) {
        if (name[i] != '') plain_text += encodeURIComponent(name[i]) + "=" + encodeURIComponent(value[i]) + "&";
    }

    //마지막에 &를 없애기 위함
    if (plain_text != "") plain_text = plain_text.substr(0, plain_text.length - 1);

    return plain_text;
}

/*------------------------------------------------------------------------------
 * titile : IBSheet의 조회,저장시 사용되는 함수
 * paramList : 
 * param1 : s_SAVENAME 객체를 담고 있는 form 객체
 * param2 : 조회해야 할 시트 객체
 * param3.. : 여러개 시트를 한번에 조회하는 경우 시트의 개수만큼 붙인다.
-------------------------------------------------------------------------------*/
function IBS_SaveName() {
    var param = arguments;
    if (param.length < 2) {
        IBS_ShowErrMsg("최하 두개의 인자가 필요합니다.");
        return;
    }

    if (param.length == 2) {
        param[0].s_SAVENAME.value = IBS_ConcatSaveName(param[1]);
    } else {
        param[0].s_SAVENAME.value = "";
        for (var i = 1; i < param.length; i++) {
            param[0].s_SAVENAME.value += IBS_ConcatSaveName(param[i]) + "@@";
        }
        var tempStr = param[0].s_SAVENAME.value;
        param[0].s_SAVENAME.value = tempStr.substring(0, tempStr.length - 2);
    }
}

function IBS_ConcatSaveName(sheet) {
    var lr  = sheet.GetDataRows(),
        lc  = sheet.LastCol(),
        res = [],
        r   = 0,
        c   = 0,
        cn  = "",
        sn  = "";

    for (r = 0; r < lr; r++) {
        for (c = 0; c <= lc; c++) {
            cn = sheet.GetColName(c);
            sn = sheet.ColSaveName(r, c);

            if (cn !== sn) {
                res.push(sn);
            }
        }
    }
    
    return res.join("|");
}

/*------------------------------------------------------------------------------
 * method : GetSaveJson
 * desc : 지정한 상태에 대한 데이터를 json 형태로 반환한다.
 * param list
 * param1 : IBSheet Object
 * param2 : 상태 (I|U|D)
 * param3 : SkipCol list 
-------------------------------------------------------------------------------*/
function GetSaveJson2(sheet, status, skipcols) {
    if (sheet == null) {
        alert("GetSaveJson2 함수의 첫번째 인자는 ibsheet 객체여야 합니다.");
        return;
    }

    var skipcolsArr = null;
    if (skipcols != null) {
        skipcolsArr = skipcols.split("|");
    }

    var rtnJson = {};
    if (status == null) {
        var temp = GetJsonStatus(sheet, "I", skipcolsArr);
        if (temp) rtnJson["INSERT"] = temp;
        temp = GetJsonStatus(sheet, "D", skipcolsArr);
        if (temp) rtnJson["DELETE"] = temp;
        temp = GetJsonStatus(sheet, "U", skipcolsArr);
        if (temp) rtnJson["UPDATE"] = temp;
    } else {
        switch (status) {
            case "I":
                rtnJson["INSERT"] = GetJsonStatus(sheet, "I", skipcolsArr);
                break;
            case "U":
                rtnJson["UPDATE"] = GetJsonStatus(sheet, "U", skipcolsArr);
                break;
            case "D":
                rtnJson["DELETE"] = GetJsonStatus(sheet, "D", skipcolsArr);
                break;
        }
        GetJsonStatus(sheet, status);
    }
    return rtnJson;
}

function GetJsonStatus(sheet, status, skipcolsArr) {
    var rtnJson = new Array();
    //지정한 상태 값을 갖는 행을 뽑는다.
    var rows = sheet.FindStatusRow(status);

    if (rows == "") return null;

    var rowArr = rows.split(";");

    for (var i = 0; i < rowArr.length; i++) {
        var temp = sheet.GetRowJson(rowArr[i]);
        if (skipcolsArr != null) {
            for (var c = 0; c < skipcolsArr.length; c++) {
                delete temp[skipcolsArr[c]];
            }
        }
        rtnJson.push(temp);
    }
    return rtnJson;
}

/**
    IBSheet 초기화 작업을 일괄 처리 한다.
    @method     IBS_InitSheet
    @public
    @param      {object}    sheet               대상 시트 객체
    @param      {object}    info                초기화 정보
    @param      {object}    info.Cols           컬럼 초기화 정보 객체
    @param      {object}    [info.Cfg]          시트 초기화 정보 객체
    @param      {object}    [info.Headers]      헤더 초기화 정보 객체
    @param      {object}    [info.HeaderMode]   헤더 모드 정보 객체
*/
function IBS_InitSheet(sheet, info) {
    var cInfo         = {},
        colsHeader    = [],
		headerUnitPos    = [],
        useColsHeader = 0,
        max           = 0,
        cnt           = 0,
        htmlHeader    = [],
        dataRows      = 1;

    function appendHeaderText(last, col, header, unitPos) {
        var unitHeader = header,
            i          = 0,
            len        = 0;

        if (!_ibsUtil.isArray(header)) {
            unitHeader = header.split("|");
        }
		

        useColsHeader = 1;
        len = unitHeader.length;

        if (cnt < len) {
            cnt = len;
        }
		
		if (typeof unitPos == "undefined") {
			unitPos = 0;
		}

        for (i = 0; i < len; i++) {
            if (typeof colsHeader[last + i] === "undefined") {
                colsHeader[last + i] = [];
            }
			
			if (typeof headerUnitPos[last + i] === "undefined") {
                headerUnitPos[last + i] = unitPos;
            }

            colsHeader[last + i][col] = unitHeader[i];
        }
    };

    // 필수 입력 요소 체크
    if (!sheet || !info || !info.Cols) {
        alert("시트 초기화 정보가 올바르지 않습니다.");
        return;
    }

    cInfo = CloneArray(info);

    // DataRows 설정
    if (cInfo.Cols[0] && typeof cInfo.Cols[0].length !== "undefined") {
        dataRows = cInfo.Cols.length;
    }

    // Cfg 기본값 설정
    if (!cInfo.Cfg) {
        cInfo.Cfg = {};
    }

    // Headers 기본값 설정
    if (!cInfo.Headers) {
        cInfo.Headers = [{
            Text: "",
            Align: "Center"
        }];
    }

    // HeaderMode 기본값 설정 및 Align 처리
    if (!cInfo.HeaderMode) {
        cInfo.HeaderMode = {};
    } else {
        if (cInfo.HeaderMode.Align) {
            var header = cInfo.Headers;
            for (var i = 0, len = header.length; i < len; i++) {
                header[i].Align = cInfo.HeaderMode.Align;
            }
        }
    }

    for (var i = 0, len = cInfo.Cols.length; i < len; i++) {
        var col = cInfo.Cols[i];

        if (typeof col.Header === "undefined") {
            for (var j = 0, len2 = col.length; j < len2; j++) {
                var col2 = col[j];

                if (typeof col2.Header !== "undefined") {
                    appendHeaderText(max, j, col2.Header, i);
                    delete col2.Header;
                }
            }

            max += cnt;
            cnt = 0;
        } else {
            appendHeaderText(0, i, col.Header, 0);
            delete col.Header;
        }

        if (col.HeaderHtml) {
            var ht = col.HeaderHtml;
            if (!_ibsUtil.isArray(ht)) {
                ht = [ht];
            }
            var hh = {
                Col: i,
                Html: ht
            };
            htmlHeader.push(hh);
        }
    }

    if (useColsHeader) {
        cInfo.Headers = [];
        for (var i = 0, len = colsHeader.length; i < len; i++) {
            var header = {};

            if (typeof colsHeader[i] === "undefined") {
                header.Text = "";
            } else {
                header.Text = colsHeader[i].join("|");
            }

            header.Align = cInfo.HeaderMode.Align || "Center";
            cInfo.Headers.push(header);
        }
    }

    sheet.SetConfig(cInfo.Cfg);
    sheet.InitHeaders(cInfo.Headers, cInfo.HeaderMode);
    sheet.InitColumns(cInfo.Cols, dataRows);
	if (typeof sheet.InitHeadersUnitPos !="undefined") {
        sheet.InitHeadersUnitPos(headerUnitPos);
    }

    //HeaderHtml
    for (var i = 0, len = htmlHeader.length; i < len; i++) {
        var ht = htmlHeader[i];
        for (var j = 0, len2 = ht.Html.length; j < len2; j++) {
            if (ht.Html[j] && ht.Html[j] !== "") {
                sheet.SetHtmlHeaderValue(j, ht.Col, ht.Html[j]);
            }
        }
    }
}

/*------------------------------------------------------------------------------
* method : IBS_CopyJson2Form
* desc : json 데이터를 이름을 기준으로 폼객체에 넣는다.
* param list
* param1 : json 객체
* param2 : 대상 폼 name

json 자료 구조 :
{"폼객체명":{"객체명":"값","객체명2":"값2"}}
ex){"aFrm":{"sa_no":"12345","sa_name":"손이창","grade":"a3","married":"NO","enter_date":"2012-12-31"}}
-------------------------------------------------------------------------------*/
function IBS_CopyJson2Form(jsonobj, frmName) {
    var json,
        obj,
        stype,
        idx,
        max;

    if (typeof frmName == "object") {
        frmName = frmName.name;
    }

    json = jsonobj[frmName];

    for (j in json) {
        obj = null;

        try {
            obj = document[frmName][j];
            if (obj == null || typeof obj == "undefined") {
                obj = document.getElementById(j);
            }
            if (obj == null || typeof obj == "undefined") {
                continue;
            }
        } catch (e) {
            //alert(e.message);
        }

        stype = (obj.type);

        if (typeof stype == "undefined" && obj.length > 0) {
            stype = obj[0].type;
        }

        switch (stype) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "select-one":
                obj.value = json[j];
                break;
            case "radio":
                obj.checked = json[j];
                break;
            case "checkbox":
                obj.checked = json[j];
                break;
            default:
                obj.value = json[j];
                break;
        } //end of switch
    }
}

/*------------------------------------------------------------------------------
method : IBS_CopyForm2Sheet()
desc  : Form객체에 있는 내용을 시트에 복사
param list
param : json 유형

param 내부 설정값
sheet : 값을 입력 받을 ibsheet 객체 (필수)
form : copy할 폼객체 (필수)
row : ibsheet 객체의 행 (default : 현재 선택된 행)
sheetPreFiex : 맵핑할 시트의 SavaName 앞에 PreFix 문자 (default : "")
formPreFiex : 맵핑할 폼객체의 이름 혹은 id 앞에  PreFix 문자 (default : "")
useOnChange : 시트값 변경시 OnChange 이벤트 사용 유무 (default : false)
-------------------------------------------------------------------------------*/
function IBS_CopyForm2Sheet(param) {
    var sheetobj,
        formobj,
        row,
        sheetPreFix,
        frmPreFix,
        uoc,
        col,
        max,
        colSaveName,
        baseSaveName,
        frmchild,
        sType,
        sValue;

    if ((!param.sheet) || (!param.sheet.IBSheetVersion)) {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 sheet 인자가 없거나 ibsheet객체가 아닙니다.");
        return false;
    }
    if (param.form == null || typeof param.form != "object" || param.form.tagName != "FORM") {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 form 인자가 없거나 FORM 객체가 아닙니다.");
        return false;
    }

    sheetobj = param.sheet;
    formobj = param.form;
    row = param.row == null ? sheetobj.GetSelectRow() : param.row;
    sheetPreFix = param.sheetPreFix == null ? "" : param.sheetPreFix;
    frmPreFix = param.formPreFix == null ? "" : param.formPreFix;
    uoc = param.useOnChange == null ? 0 : param.useOnChange;
    if (row < 0) {
        alert("선택된 행이 존재하지 않습니다.");
        return;
    }

    //Sheet의 컬럼개수만큼 찾아서 HTML의 Form 각 Control에 값을 설정한다.
    //컬럼개수만큼 루프 실행
    for (col = 0, max = sheetobj.LastCol(); col <= max; col++) {
        //컬럼의 별명을 문자열로 가져온다.
        colSaveName = sheetobj.ColSaveName(col);
        if (colSaveName == "") {
            continue;
        }
        //PreFix가 붙지 않은 형태의 SaveName을 가져온다.
        baseSaveName = colSaveName.substring(sheetPreFix.length);

        frmchild = null;
        try {
            //폼에 있는 해당 이름의 컨트롤을 가져온다.예)"frm_CardNo"
            frmchild = formobj[frmPreFix + baseSaveName];
        } catch (e) {
            alert(e);
        }

        //폼에 해당하는 이름의 컨트롤이 없는 경우는 계속 진행한다.
        if (frmchild == null) continue;

        sType = frmchild.type;
        sValue = "";

        //radio의 경우 frmchild가 배열형태가 되므로, frmchild.type으로는 타입을 알수 없다.
        if (typeof sType == "undefined" && frmchild.length > 0) {
            sType = frmchild[0].type;
        }

        //타입별로 값을 설정한다.
        switch (sType) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "radio":
                for (idx = 0; idx < frmchild.length; idx++) {
                    if (frmchild[idx].checked) {
                        sValue = frmchild[idx].value;
                        break;
                    }
                }
                break;
            case "checkbox":
                sValue = (frmchild.checked) ? 1 : 0;
                break;
            default:
                sValue = frmchild.value;
        } //end of switch

        sheetobj.SetCellValue(row, sheetPreFix + baseSaveName, sValue, uoc);
    } //end of for(col)

    //정상적인 처리완료
    return true;
}

/*----------------------------------------------------------------------------
method : IBS_CopySheet2Form()
desc : 시트의 한 행을 폼객체에 복사

param list
param : json 유형

param 내부 설정값
sheet : 값을 입력 받을 ibsheet 객체 (필수)
form : copy할 폼객체 (필수)
row : ibsheet 객체의 행 (default : 현재 선택된 행)
sheetPreFiex : 맵핑할 시트의 SavaName 앞에 PreFix 문자 (default : "")
formPreFiex : 맵핑할 폼객체의 이름 혹은 id 앞에  PreFix 문자 (default : "")
-----------------------------------------------------------------------------*/
function IBS_CopySheet2Form(param) {
    var sheetobj,
        formobj,
        row,
        sheetPreFix,
        frmPreFix,
        col,
        max,
        rmax,
        colSaveName,
        baseSaveName,
        sheetvalue,
        frmchild,
        sType,
        sValue;

    if ((!param.sheet) || (!param.sheet.IBSheetVersion)) {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 sheet 인자가 없거나 ibsheet객체가 아닙니다.");
        return false;
    }

    if (param.form == null || typeof param.form != "object" || param.form.tagName != "FORM") {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 form 인자가 없거나 FORM 객체가 아닙니다.");
        return false;
    }
    sheetobj = param.sheet;
    formobj = param.form;
    row = param.row == null ? sheetobj.GetSelectRow() : param.row;
    sheetPreFix = param.sheetPreFix == null ? "" : param.sheetPreFix;
    frmPreFix = param.formPreFix == null ? "" : param.formPreFix;

    if (row < 0) {
        alert("선택된 행이 존재하지 않습니다.");
        return;
    }

    //Sheet의 컬럼개수만큼 찾아서 HTML의 Form 각 Control에 값을 설정한다.
    //컬럼개수만큼 루프 실행
    for (col = 0, max = sheetobj.LastCol(); col <= max; col++) {
        //컬럼의 별명을 문자열로 가져온다.
        colSaveName = sheetobj.ColSaveName(col)
        if (colSaveName == "") {
            continue;
        }
        //PreFix가 붙지 않은 형태의 SaveName을 가져온다.
        baseSaveName = colSaveName.substring(sheetPreFix.length);

        sheetvalue = sheetobj.GetCellText(row, sheetPreFix + baseSaveName);

        frmchild = null;
        try {
            //폼에 있는 해당 이름의 컨트롤을 가져온다.예)"frm_CardNo"
            frmchild = formobj[frmPreFix + baseSaveName];
        } catch (e) {

        }

        //폼에 해당하는 이름의 컨트롤이 없는 경우는 계속 진행한다.
        if (frmchild == null) {
            continue;
        }

        sType = frmchild.type;
        sValue = "";
        //radio의 경우 frmchild가 배열형태가 되므로, frmchild.type으로는 타입을 알수 없다.
        if (typeof sType == "undefined" && frmchild.length > 0) {
            sType = frmchild[0].type;
        }

        //타입별로 값을 설정한다.
        switch (sType) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "select-one":
                frmchild.value = sheetobj.GetCellValue(row, sheetPreFix + baseSaveName);
                break;
            case "radio":
                for (idx = 0, rmax = frmchild.length; idx < rmax; idx++) {
                    if (frmchild[idx].value == sheetvalue) {
                        frmchild[idx].checked = true;
                        break;
                    }
                }
                break;
            case "checkbox":
                frmchild.checked = (sheetobj.GetCellValue(row, sheetPreFix + baseSaveName) == 1);
                break;
            default:
                frmchild.value = sheetvalue;
                break;
        } //end of switch
    } //end of for(col)

    //정상적인 처리완료
    return true;
}