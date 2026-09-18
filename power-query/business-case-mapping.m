// Business Case & Mediation Mapping (LGA) — Power Query (M) — key steps (representative)

let
    Source = Csv.Document(File.Contents("CaseExport.csv"), [Delimiter=",", Encoding=65001]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    MergedLGA = Table.NestedJoin(PromotedHeaders, {"Postcode"}, PostcodeToLGARef, {"Postcode"}, "LGAInfo", JoinKind.LeftOuter),
    ExpandedLGA = Table.ExpandTableColumn(MergedLGA, "LGAInfo", {"LGA"}),
    StandardisedLGA = Table.TransformColumns(ExpandedLGA, {"LGA", each Text.Proper(Text.Trim(_))}),
    AggregatedMonthly = Table.Group(StandardisedLGA, {"LGA", "CaseType", "Date.[Year]", "Date.[Month]"}, {{"CaseCount", each Table.RowCount(_), Int64.Type}})
in
    AggregatedMonthly
