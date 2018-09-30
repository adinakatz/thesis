view: emissions {
  derived_table: {
    sql:
      SELECT *, "Argticulture" as category FROM `lookerdata.un_data.emissions_agriculture_total`
      UNION ALL
      SELECT *, "Land Use" as category FROM `lookerdata.un_data.emissions_land_use_total`
    ;;
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

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
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
