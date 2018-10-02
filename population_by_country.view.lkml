view: population_by_country {

## DT of population without duplicate data from territories

derived_table: {
  sql:
    SELECT CONCAT(cast(area_code as string), ' ', cast(item_code as string), ' ', cast(element_code as string), ' ', cast(year_code as string)) as prim_key, area_code, area, item_code, item, element_code, element, year_code, year, value * 1000 as population
    FROM `lookerdata.un_data.population`

    WHERE (area NOT LIKE '%Polynesia%'
    AND area NOT LIKE '%Micronesia%' AND area NOT LIKE '%Melanesia%'
    AND area NOT LIKE '%Australia & New Zealand%' AND area NOT LIKE '%Oceania%'
    AND area NOT LIKE '%Europe%' AND area NOT LIKE '%Asia'
    AND area NOT LIKE '%South America%' AND area NOT LIKE '%Caribbean%'
    AND area NOT LIKE '%Central America%' AND area NOT LIKE '%Northern America%'
    AND area NOT LIKE '%Americas%' AND area NOT LIKE '%Africa'
    AND area NOT LIKE '%Net Food%' AND area NOT LIKE '%Low Income%'
    AND area NOT LIKE '%Small Island%' AND area NOT LIKE '%Land Locked%'
    AND area NOT LIKE '%China,%' AND area NOT LIKE '%Oceana%'
    AND area NOT LIKE '%Channel Islands%' AND area NOT LIKE '%Virgin Islands%'
    AND area NOT LIKE '%Least Dev%')
    AND element LIKE '%Total Population - Both sexes%';;
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

measure: sum_population {
  type: sum
  sql: ${TABLE}.population ;;
}
measure: count {
  type: count
}

}
