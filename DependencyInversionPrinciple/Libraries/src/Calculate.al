namespace DependencyInversion.Libraries.Math;

codeunit 50000 Calculate implements ICalculate
{
    Access = Internal;
    procedure Multiply(a: Decimal; b: Decimal): Decimal;
    begin
        exit(a * b);
    end;

    procedure IsCalculateActive(): Boolean;
    begin
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CalculateHandler, 'OnGetImplementation', '', true, false)]
    local procedure OnGetImplementation(var isHandled: Boolean; var implementation: Interface ICalculate)
    var
        calculate: Codeunit Calculate;
    begin
        isHandled := true;
        implementation := calculate;
    end;
}
