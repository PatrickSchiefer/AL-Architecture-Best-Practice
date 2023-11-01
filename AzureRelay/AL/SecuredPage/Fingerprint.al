codeunit 50400 Fingerprint
{
    var
        ServiceBusRelay: codeunit AzureServiceBusRelay;
        CalculatorPluginNameTok: Label '/fingerprint/V1.0', Locked = true;
        FingerprintFuncDefTok: Label '/GetConsent?message=%1', Locked = true;

    procedure GetConsent(message: Text) Result: Boolean;
    var
        ResultText: Text;
    begin
        ServiceBusRelay.Get(CalculatorPluginNameTok + StrSubstNo(FingerprintFuncDefTok, message), ResultText);
        Evaluate(Result, ResultText);
    end;
}
