view: emissions_land_use{

  derived_table: {
    sql: SELECT *, 'Burning Biomass' as emission_type
    FROM `un_data.emissions_land_use_burning_biomass`
    UNION ALL
    SELECT *, 'Cropland' as emission_type
    FROM `un_data.emissions_land_use_cropland`
    UNION ALL
    SELECT *, 'Forest Land' as emission_type
    FROM `un_data.emissions_land_use_forest_land`
    UNION ALL
    SELECT *, 'Grassland' as emission_type
    FROM `un_data.emissions_land_use_grassland`;;
  }

  dimension: area {
    type: string
    sql: ${TABLE}.area ;;
  }

  dimension: area_code {
    type: number
    sql: ${TABLE}.area_code ;;
  }

  dimension: element {
    type: string
    sql: ${TABLE}.element ;;
  }

  dimension: element_code {
    type: number
    sql: ${TABLE}.element_code ;;
  }

  dimension: flag {
    type: string
    sql: ${TABLE}.flag ;;
  }

  dimension: item {
    type: string
    sql: ${TABLE}.item ;;
  }

  dimension: item_code {
    type: number
    sql: ${TABLE}.item_code ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: year_code {
    type: number
    sql: ${TABLE}.year_code ;;
  }

  dimension: emission_type {
    type: string
    sql: ${TABLE}.emission_type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_value {
    type: sum
    sql: ${TABLE}.value ;;
  }
}
