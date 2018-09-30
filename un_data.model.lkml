connection: "lookerdata_publicdata_standard_sql"

include: "*.view.lkml"                       # include all views in this project


explore: population_all {
  label: "Population"

  join: population_by_world_region {
    sql_on: ${population_all.prim_key} = ${population_by_world_region.prim_key} ;;
    relationship: many_to_one
  }

  join: population_by_country {
    sql_on: ${population_all.prim_key} = ${population_by_country.prim_key} ;;
    relationship: many_to_one
  }
}

explore: emissions {}

# explore: emissions_land_use_total {}
#
# explore: emissions_agriculture_total {}
