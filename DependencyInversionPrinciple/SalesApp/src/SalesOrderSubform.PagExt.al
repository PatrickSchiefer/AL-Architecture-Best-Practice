namespace DependencyInversion.Sales;

using Microsoft.Sales.Document;

pageextension 50100 "SalesOrderSubformExt" extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field(MyUnitPrice; Rec.MyUnitPrice)
            {
                ApplicationArea = All;
            }
            field(MyPrice; Rec.MyPrice)
            {
                ApplicationArea = All;
            }
        }
    }
}