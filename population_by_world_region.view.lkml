view: population_by_world_region {

## DT of population without duplicate data from territories

  derived_table: {
    sql:
    SELECT CONCAT(cast(area_code as string), ' ', cast(item_code as string), ' ', cast(element_code as string), ' ', cast(year_code as string)) as prim_key, area_code, area, item_code, item, element_code, element, year_code, year, value * 1000 as population
    FROM `lookerdata.un_data.population`

    WHERE (area LIKE '%World%'
    OR area LIKE 'Australia & New Zealand'
    OR area LIKE 'Caribbean'
    OR area LIKE 'Central America'
    OR area LIKE 'Central Asia'
    OR area LIKE 'Eastern Africa'
    OR area LIKE 'Eastern Asia'
    OR area LIKE 'Eastern Europe'
    OR area LIKE 'Melanesia'
    OR area LIKE 'Micronesia'
    OR area LIKE 'Middle Africa'
    OR area LIKE 'Northern Africa'
    OR area LIKE 'Northern America'
    OR area LIKE 'Northern Europe'
    OR area LIKE 'Polynesia'
    OR area LIKE 'South America'
    OR area LIKE 'South-Eastern Asia'
    OR area LIKE 'Southern Asia'
    OR area LIKE 'Southern Europe'
    OR area LIKE 'Southern Africa'
    OR area LIKE 'Western Europe'
    OR area LIKE 'Western Asia'
    OR area LIKE 'Western Africa');;

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
  type: date_year
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
