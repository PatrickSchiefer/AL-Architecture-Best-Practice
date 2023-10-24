namespace PatrickSchiefer.Adapter;

interface IOutputFormatAdapter
{
    procedure Adapt(source: Text): Text;
}