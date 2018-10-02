view: emissions {
  derived_table: {
    sql:
      SELECT CONCAT(cast(area_code as string), ' ', cast(item_code as string), ' ', cast(element_code as string), ' ', cast(year_code as string)) as prim_key, *, "Agriculture" as category FROM `lookerdata.un_data.emissions_agriculture_total`
      UNION ALL
      SELECT CONCAT(cast(area_code as string), ' ', cast(item_code as string), ' ', cast(element_code as string), ' ', cast(year_code as string)) as prim_key, *, "Land Use" as category FROM `lookerdata.un_data.emissions_land_use_total`
    ;;
  }

  dimension: prim_key {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
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
