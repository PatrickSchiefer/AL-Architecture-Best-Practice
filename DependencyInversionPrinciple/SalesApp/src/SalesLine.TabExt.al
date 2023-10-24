namespace DependencyInversion.Sales;
using DependencyInversion.Price;
tableextension 50100 SalesLineExt extends Microsoft.Sales.Document."Sales Line"
{
    fields
    {
        field(50100; MyUnitPrice; Decimal)
        {
            Caption = 'My Unit Price';
            DecimalPlaces = 2;

            trigger OnValidate()
            begin
                CalculateMyPrice();
            end;
        }
        field(50101; MyPrice; Decimal)
        {
            Caption = 'My Price';
            DecimalPlaces = 2;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CalculateMyPrice();
            end;
        }
    }



    procedure CalculateMyPrice()
    var
        priceCalculationHandler: Codeunit PriceCalculationHandler;
    begin
        if not priceCalculationHandler.GetImplementation().IsPriceCalculateActive() then
            exit;
        rec.Validate(MyPrice, priceCalculationHandler.GetImplementation().CalculatePrice(rec.Quantity, rec.MyUnitPrice));
    end;
}