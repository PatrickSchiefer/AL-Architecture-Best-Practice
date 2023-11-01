page 50400 SecuredPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            repeater(Repeater)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        fingerprint: Codeunit "Fingerprint";
    begin
        if not fingerprint.GetConsent('Open very secure page') then
            ERROR('You must give consent to open this page');
    end;
}