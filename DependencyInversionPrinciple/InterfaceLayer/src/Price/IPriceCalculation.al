namespace DependencyInversion.Price;

interface IPriceCalculation
{
    procedure CalculatePrice(Quantity: Decimal; Price: Decimal): Decimal;

    procedure IsPriceCalculateActive(): Boolean;
}