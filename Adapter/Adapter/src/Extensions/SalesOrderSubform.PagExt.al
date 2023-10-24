pageextension 50300 SalesOrderSubformExt extends "Sales Order Subform"
{
    actions
    {
        addfirst(processing)
        {
            action(ExportXML)
            {
                Caption = 'Export XML';
                Image = XMLFile;
                ApplicationArea = All;

                trigger OnAction()
                var
                    exportSalesLines: Codeunit ExportSalesLines;
                begin
                    Message(exportSalesLines.ExportSalesLines(rec));
                end;
            }
            action(ExportJSON)
            {
                Caption = 'Export JSON';
                Image = ExportFile;
                ApplicationArea = All;

                trigger OnAction()
                var
                    exportSalesLines: Codeunit ExportSalesLines;
                    xmltojson: Codeunit XMLToJSONAdpater;
                begin
                    exportSalesLines.SetOutputFormatAdapter(xmltojson);
                    Message(exportSalesLines.ExportSalesLines(rec));
                end;
            }
        }
    }
}