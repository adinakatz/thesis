view: population_all {

derived_table: {
  sql: SELECT CONCAT(cast(area_code as string), ' ', cast(item_code as string), ' ', cast(element_code as string), ' ', cast(year_code as string)) as prim_key,
    area_code, area, item_code, item, element_code, element, year_code, year, value * 1000 as population
    FROM `lookerdata.un_data.population`;;

}

dimension: prim_key {
  hidden: yes
  type: string
  primary_key: yes
  sql: ${TABLE}.prim_key ;;
}

dimension: area_code {
  type: number
  sql: ${TABLE}.area_code ;;
}

dimension: area {
  type: string
  sql: ${TABLE}.area ;;
  map_layer_name: countries
}

dimension: item_code {
  type: number
  sql: ${TABLE}.item_code ;;
}

dimension: item {
  type: string
  sql: ${TABLE}.item ;;
}

dimension: element_code {
  type: number
  sql: ${TABLE}.element_code ;;
}

dimension: element {
  type: string
  sql: ${TABLE}.element ;;
}

dimension: year_code {
  type: number
  sql: ${TABLE}.year_code ;;
}

dimension: year {
  type: number
  sql:  ${TABLE}.year ;;
}

dimension: population {
  type: number
  sql: ${TABLE}.population ;;
}

measure: count {
  type: count
}

}
