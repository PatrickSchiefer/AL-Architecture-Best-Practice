namespace PatrickSchiefer.Adapter;
using System.IO;
codeunit 50300 XMLToJSONAdpater implements IOutputFormatAdapter
{


    procedure Adapt(source: Text): Text;
    begin
        exit(ConvertXmlToJson(source));
    end;




















    ///////////////////////////////////////////////////////////////////

    // XML Conversion Code by Patrick Pichler
    internal procedure ConvertXmlToJson(source: Text) JsonText: Text
    var
        JsonBig: BigText;
    begin
        IF NOT XMLToJson(JsonBig, source) THEN
            ERROR(GETLASTERRORTEXT);

        JsonBig.GetSubText(JsonText, 1)
    end;

    [TryFunction]
    local procedure XMLToJson(var JsonTxt: BigText; source: Text)
    var
        TempXMLBuffer: Record "XML Buffer" temporary;
        TempXMLBuffer2: Record "XML Buffer" temporary;
    begin
        TempXMLBuffer.LoadFromText(source);
        if TempXMLBuffer.FindFirst() then begin
            JsonTxt.AddText('{');
            TempXMLBuffer.FindChildElements(TempXMLBuffer2);
            XMLtoJsonRecursion(JsonTxt, TempXMLBuffer2);
            JsonTxt.AddText('}');
        end;
    end;

    local procedure XMLtoJsonRecursion(var JsonTxt: BigText; var XMLBuffer: Record "XML Buffer" temporary)
    var
        TempXMLBuffer2: Record "XML Buffer" temporary;
        SecendElement: Boolean;
        SecendAttribute: Boolean;
        IsArray: Boolean;
        LastName: Text[50];
        JsonTextVar: Text;
        ArrayNode_Txt: Label '_JsonArray_', Locked = true;
    begin
        if XMLBuffer.FindSet() then
            repeat
                JsonTextVar := '';
                if XMLBuffer.HasChildNodes() or (XMLBuffer.CountAttributes() > 0) then begin
                    if SecendElement then
                        JsonTxt.AddText(',');
                    SecendElement := true;
                    if IsArray then
                        JsonTextVar += '{'
                    else begin
                        if XMLBuffer.Name.Contains(ArrayNode_Txt) then begin
                            JsonTextVar += '"' + CopyStr(XMLBuffer.Name, 1, StrLen(XMLBuffer.Name) - StrLen(ArrayNode_Txt)) + '": [{';
                            IsArray := true;
                        end else
                            JsonTextVar += '"' + XMLBuffer.Name + '": {';
                        LastName := XMLBuffer.Name;
                    end;
                    if XMLBuffer.CountAttributes() > 0 then begin
                        SecendAttribute := false;
                        XMLBuffer.FindAttributes(TempXMLBuffer2);
                        if TempXMLBuffer2.FindSet() then
                            repeat
                                if not SecendAttribute then begin
                                    JsonTextVar += '"@' + XMLBuffer.Name + '": "' + XMLBuffer.Value + '"';
                                    SecendAttribute := true;
                                end else begin
                                    JsonTextVar += ',"@' + XMLBuffer.Name + '": "' + XMLBuffer.Value + '"';
                                end;
                            until TempXMLBuffer2.Next() = 0;
                    end;
                    if not IsArray then begin
                        if XMLBuffer.Next() <> 0 then begin
                            if XMLBuffer.Name = LastName then begin
                                IsArray := true;
                                JsonTxt.AddText(CopyStr(JsonTextVar, 1, StrLen(JsonTextVar) - 1) + '[{');
                            end else
                                JsonTxt.AddText(JsonTextVar);
                            XMLBuffer.Next(-1);
                        end else
                            JsonTxt.AddText(JsonTextVar);
                    end else
                        JsonTxt.AddText(JsonTextVar);
                    XMLBuffer.FindChildElements(TempXMLBuffer2);
                    XMLtoJsonRecursion(JsonTxt, TempXMLBuffer2);
                    if XMLBuffer.Next() <> 0 then begin
                        IF NOT IsArray or (IsArray and (XMLBuffer.Name = LastName)) then begin
                            JsonTxt.AddText('}');
                        end else begin
                            JsonTxt.AddText('}]');
                            IsArray := false;
                        end;
                        XMLBuffer.Next(-1);
                    end else begin
                        JsonTxt.AddText('}');
                        If IsArray then begin
                            JsonTxt.AddText(']');
                            IsArray := false;
                        end;
                    end;
                end else begin
                    if SecendElement then
                        JsonTxt.AddText(',');
                    SecendElement := true;
                    if XMLBuffer.Name.Contains(ArrayNode_Txt) then begin
                        JsonTxt.AddText('"' + CopyStr(XMLBuffer.Name, 1, StrLen(XMLBuffer.Name) - StrLen(ArrayNode_Txt)) + '": ["' + XMLBuffer.Value + '"]');
                    end else
                        JsonTxt.AddText('"' + XMLBuffer.Name + '": "' + XMLBuffer.Value + '"');
                end;
            until XMLBuffer.Next() = 0;
    end;

}