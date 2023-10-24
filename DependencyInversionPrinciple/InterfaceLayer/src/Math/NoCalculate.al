namespace DependencyInversion.Libraries.Math;
codeunit 50050 NoCalculate implements ICalculate
{
    Access = Internal;
    procedure Multiply(a: Decimal; b: Decimal): Decimal;
    begin
        Error('Calculate is not implemented');
    end;

    procedure IsCalculateActive(): Boolean;
    begin
        exit(false);
    end;
}