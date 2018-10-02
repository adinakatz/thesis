view: emissions_agriculture {
  derived_table: {
    sql:
          SELECT * FROM (
          SELECT *, "Burning Crop Residues" as emission_type FROM `lookerdata.un_data.emissions_agriculture_burning_crop_residues`
          UNION ALL
          SELECT *, "Burning Savanna" as emission_type FROM `lookerdata.un_data.emissions_agriculture_burning_savanna`
          UNION ALL
          SELECT *, "Crop Residues" as emission_type FROM `lookerdata.un_data.emissions_agriculture_crop_residues`
          UNION ALL
          SELECT *, "Cultivated Organic Soils" as emission_type FROM `lookerdata.un_data.emissions_agriculture_cultivated_organic_soils`
          UNION ALL
          (SELECT *, "Energy Use" as emission_type FROM `lookerdata.un_data.emissions_agriculture_energy_use`
          WHERE Item = 'Total Energy')
          UNION ALL
          SELECT *, "Enteric Fermentation" as emission_type FROM `lookerdata.un_data.emissions_agriculture_enteric_fermentation`
          UNION ALL
          SELECT *, "Manure Applied to Soils" as emission_type FROM `lookerdata.un_data.emissions_agriculture_manure_applied_to_soils`
          UNION ALL
          SELECT *, "Manure left on Pasture" as emission_type FROM `lookerdata.un_data.emissions_agriculture_manure_left_on_pasture`
          UNION ALL
          SELECT *, "Manure Management" as emission_type FROM `lookerdata.un_data.emissions_agriculture_manure_management`
          UNION ALL
          SELECT *, "Rice Cultivation" as emission_type FROM `lookerdata.un_data.emissions_agriculture_rice_cultivation`
          UNION ALL
          SELECT *, "Synthetic Fertilizers" as emission_type FROM `lookerdata.un_data.emissions_agriculture_synthetic_fertilizers`
          )
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
          AND area NOT LIKE 'USSR'

          AND item NOT IN ('Swine, market','Swine, breeding','Sheep and Goats','Poultry Birds','Mules and Asses',
                                'Chickens, layers','Chickens, broilers','Cattle, non-dairy','Cattle, dairy',
                                'Camels and Llamas','All Animals','All Crops','Savanna and woody savanna',
                                'Closed and open shrubland','Burning - all categories','Cropland and grassland organic soils')

          AND element LIKE '%Emissions (CO2eq) (%';;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.area ;;
    map_layer_name: countries
    link: {
      label: "Country Dashboard"
      url: "/dashboards/233"
    }
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
    hidden: yes
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

  measure: total_emissions {
    type: sum
    sql: ${TABLE}.value ;;
    drill_fields: [emission_type, total_emissions]
  }

  measure: percent_of_total_emissions {
    type: number
    sql: ${total_emissions} / ${emissions_aggriculture_rank_dt.world_total_emissions} ;;
    value_format_name: percent_1
  }
}
