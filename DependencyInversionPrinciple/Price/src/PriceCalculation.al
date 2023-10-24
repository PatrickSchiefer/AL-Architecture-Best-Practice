namespace DependencyInversion.Price;
using DependencyInversion.Libraries.Math;

codeunit 50149 PriceCalculation implements IPriceCalculation
{
    procedure CalculatePrice(Quantity: Decimal; Price: Decimal): Decimal;
    var
        CalculationHandler: Codeunit CalculateHandler;
    begin
        if not CalculationHandler.GetImplementation().IsCalculateActive() then
            Error('Calculation is not installed');

        exit(CalculationHandler.GetImplementation().Multiply(Quantity, Price));
    end;

    procedure IsPriceCalculateActive(): Boolean;
    begin
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::PriceCalculationHandler, 'OnGetImplementation', '', true, false)]
    local procedure OnGetImplementation(var isHandled: Boolean; var implementation: Interface IPriceCalculation)
    var
        calculate: Codeunit PriceCalculation;
    begin
        isHandled := true;
        implementation := calculate;
    end;
}