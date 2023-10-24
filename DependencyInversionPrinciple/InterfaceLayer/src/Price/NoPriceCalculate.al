namespace DependencyInversion.Price;
codeunit 50052 NoPriceCalculate implements IPriceCalculation
{
    Access = Internal;

    procedure CalculatePrice(Quantity: Decimal; Price: Decimal): Decimal;
    begin
        Error('Calculate is not implemented');
    end;

    procedure IsPriceCalculateActive(): Boolean;
    begin
        exit(false);
    end;
}