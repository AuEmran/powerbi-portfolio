// Laptop Asset Lifecycle & Warranty Management — Power Query (M) — key steps (representative)

let
    Source = Excel.Workbook(File.Contents("AssetExport.xlsx"), null, true),
    AssetTable = Source{[Item="Assets",Kind="Table"]}[Data],
    MergedWithModel = Table.NestedJoin(AssetTable, {"DeviceModel"}, DeviceModelRef, {"Model"}, "ModelInfo", JoinKind.LeftOuter),
    ExpandedModel = Table.ExpandTableColumn(MergedWithModel, "ModelInfo", {"UnitReplacementCost", "WarrantyTermMonths", "IsStandard"}),
    CalculatedWarrantyEnd = Table.AddColumn(ExpandedModel, "WarrantyEndDate", each Date.AddMonths([PurchaseDate], [WarrantyTermMonths])),
    FlaggedStatus = Table.AddColumn(CalculatedWarrantyEnd, "Status", each if [LastCheckInDate] = null then "Inactive" else "Active"),
    RemovedColumns = Table.RemoveColumns(FlaggedStatus, {"LastCheckInDate"})
in
    RemovedColumns
