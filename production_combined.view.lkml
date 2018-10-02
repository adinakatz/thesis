view: production_combined {
  derived_table: {
    sql:
      SELECT * FROM
        ((SELECT *, "Crops" as category FROM `un_data.production_crops`
        WHERE ITEM NOT IN ('Cereals,Total','Coarse Grain, Total','Vegetables Primary','Roots and Tubers,Total','Fruit Primary',
        'Oilcrops, Cake Equivalent','Oilcrops, Oil Equivalent','Pulses,Total','Citrus Fruit,Total',
        'Citrus Fruit,Total','Treenuts,Total','Fibre Crops Primary'))
        UNION ALL
        (SELECT *, "Crops Processed" as category FROM `un_data.production_crops_processed`
        WHERE unit = 'tonnes')
        UNION ALL
        SELECT *, "Livestock" as category FROM `un_data.production_livestock`

        UNION ALL
        (SELECT *, "Livestock Primary" as category FROM `un_data.production_livestock_primary`
        WHERE unit = 'tonnes' AND item NOT IN ('Meat, Total','Milk, Total','Meat indigenous, total'))
        UNION ALL
        SELECT *, "Livestock Processed" as category FROM `un_data.production_livestock_processed`)
      WHERE area NOT LIKE '%Polynesia%'
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
      AND area NOT LIKE '%Least Dev%'
      AND area NOT LIKE 'Non-Annex I countries'
      AND area NOT LIKE 'Annex I countries'
      AND area NOT LIKE 'OECD'
      AND item NOT IN ('Swine, market','Swine, breeding','Sheep and Goats','Poultry Birds','Mules and Asses',
                            'Chickens, layers','Chickens, broilers','Cattle, non-dairy','Cattle, dairy',
                            'Camels and Llamas','All Animals','All Crops','Savanna and woody savanna',
                            'Closed and open shrubland','Burning - all categories','Cattle and Buffaloes','Cropland and grassland organic soils');;
  }

  dimension: area {
    label: "Country"
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

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
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
    sql: CASE WHEN ${TABLE}.item IN ('Chickens', 'Ducks', 'Geese and guinea fowls', 'Pigeons, other birds',
                                    'Poultry Birds', 'Rabbits and hares', 'Rodents, other', 'Turkeys')
      THEN ${TABLE}.value * 1000
      ELSE ${TABLE}.value
      END ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: year_code {
    type: number
    sql: ${TABLE}.year_code ;;
  }

  measure: sum_value {
    label: "Total"
    type: sum
    sql: ${value} ;;
  }
  measure: count {
    type: count
    drill_fields: []
  }

}
