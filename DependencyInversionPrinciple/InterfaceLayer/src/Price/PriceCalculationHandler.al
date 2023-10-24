namespace DependencyInversion.Price;

codeunit 50053 PriceCalculationHandler
{
    procedure GetImplementation(): Interface IPriceCalculation;
    var
        isHandled: Boolean;
        NoCalculate: Codeunit NoPriceCalculate;
        implementation: Interface IPriceCalculation;
    begin
        OnGetImplementation(isHandled, implementation);
        if isHandled then
            exit(implementation);

        exit(NoCalculate);
    end;


    [IntegrationEvent(false, false)]
    local procedure OnGetImplementation(var isHandled: Boolean; var implementation: Interface IPriceCalculation);
    begin

    end;
}