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

explore: emissions_agriculture {
  join: population_by_country {
    sql_on: ${emissions_agriculture.area_code} = ${population_by_country.area_code}
        AND ${emissions_agriculture.year_code}= ${population_by_country.year_code};;
    relationship: many_to_one
  }
  join: emissions_aggriculture_rank_dt {
    sql_on: ${emissions_aggriculture_rank_dt.year} = ${emissions_agriculture.year} ;;
    relationship: many_to_one
  }
}

explore: emissions_land_use {
  hidden: yes
}

explore: production_combined {
  label: "Production"
}

# explore: emissions_land_use_total {}
#
# explore: emissions_agriculture_total {}
