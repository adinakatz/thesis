view: emissions_agriculture_burning_savanna {
  sql_table_name: un_data.emissions_agriculture_burning_savanna ;;

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

  measure: count {
    type: count
    drill_fields: []
  }
}
