// Business Risk Mapping — Bushfire & Flood Prone Businesses — Power Query (M) — key steps (representative)

let
    Source = Csv.Document(File.Contents("ABNBusinessRegister.csv"), [Delimiter=",", Encoding=65001]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    StandardisedIndustry = Table.TransformColumns(PromotedHeaders, {"IndustryDivision", each Text.Proper(Text.Trim(_))}),
    MergedBushfireFlag = Table.NestedJoin(StandardisedIndustry, {"Latitude", "Longitude"}, BushfireProneLandLayer, {"Latitude", "Longitude"}, "BushfireMatch", JoinKind.LeftOuter),
    MergedFloodFlag = Table.NestedJoin(MergedBushfireFlag, {"Latitude", "Longitude"}, LEPFloodLayer, {"Latitude", "Longitude"}, "FloodMatch", JoinKind.LeftOuter),
    FlaggedHazardType = Table.AddColumn(MergedFloodFlag, "HazardType", each
        if Table.RowCount([BushfireMatch]) > 0 then "Bushfire Prone"
        else if Table.RowCount([FloodMatch]) > 0 then "Flood Prone"
        else "Not Prone")
in
    FlaggedHazardType
