// Mobile Fleet Management — Power Query (M) — key steps (representative)

let
    Source = Folder.Files("BillingExports"),
    FilteredExcelOnly = Table.SelectRows(Source, each Text.EndsWith([Name], ".xlsx")),
    CombinedBilling = Table.Combine(Table.TransformColumns(FilteredExcelOnly, {"Content", each Excel.Workbook(_, true){0}[Data]})),
    StandardisedCarrier = Table.TransformColumns(CombinedBilling, {"Carrier", each Text.Proper(Text.Trim(_))}),
    MergedRegistration = Table.NestedJoin(StandardisedCarrier, {"ServiceNumber"}, RegistrationExport, {"ServiceNumber"}, "RegInfo", JoinKind.LeftOuter),
    ExpandedRegistration = Table.ExpandTableColumn(MergedRegistration, "RegInfo", {"RegistrationStatus"}),
    ZeroUsageFlag = Table.AddColumn(ExpandedRegistration, "ZeroUsage6Mth", each if [UsageLast6Mth] = 0 then true else false)
in
    ZeroUsageFlag
