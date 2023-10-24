namespace DependencyInversion.Libraries.Math;

interface ICalculate
{
    procedure Multiply(a: Decimal; b: Decimal): Decimal;

    procedure IsCalculateActive(): Boolean;
}