namespace PatrickSchiefer.Export;
using Microsoft.Sales.Document;
using System.IO;
using PatrickSchiefer.Adapter;
using System.Utilities;

codeunit 50301 ExportSalesLines
{
    procedure ExportSalesLines(rec: Record "Sales Line") result: Text;
    var
        xmlbuffer: Record "XML Buffer" temporary;
        tempBlob: Codeunit "Temp Blob";
        inStr: InStream;
    begin
        xmlbuffer.AddGroupElement('SalesLines');
        repeat
            xmlbuffer.AddGroupElement('line');
            xmlbuffer.AddElement('DocumentType', Format(rec."Document Type".AsInteger()));
            xmlbuffer.AddElement('DocumentNo', rec."Document No.");
            xmlbuffer.AddElement('Type', Format(rec."Type".AsInteger()));
            xmlbuffer.AddElement('No', rec."No.");
            xmlbuffer.AddElement('Description', rec.Description);
            xmlbuffer.AddElement('Quantity', Format(rec.Quantity));
            xmlbuffer.GetParent();
        until rec.Next = 0;
        xmlbuffer.Save(tempBlob);
        tempBlob.CreateInStream(inStr);
        inStr.ReadText(result);
        inStr.Read(result);


        if outputFormatAdapterSet then
            result := OutputFormatAdapter.Adapt(result);
    end;

    procedure SetOutputFormatAdapter(adapter: Interface IOutputFormatAdapter);
    begin
        OutputFormatAdapter := adapter;
        outputFormatAdapterSet := true;
    end;

    var
        OutputFormatAdapter: Interface IOutputFormatAdapter;
        outputFormatAdapterSet: Boolean;
}