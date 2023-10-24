namespace DependencyInversion.Libraries.Math;

codeunit 50051 CalculateHandler
{
    procedure GetImplementation(): Interface ICalculate;
    var
        isHandled: Boolean;
        NoCalculate: Codeunit NoCalculate;
        implementation: Interface ICalculate;
    begin
        OnGetImplementation(isHandled, implementation);
        if isHandled then
            exit(implementation);

        exit(NoCalculate);
    end;


    [IntegrationEvent(false, false)]
    local procedure OnGetImplementation(var isHandled: Boolean; var implementation: Interface ICalculate);
    begin

    end;
}