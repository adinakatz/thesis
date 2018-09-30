view: emissions_agriculture {
  derived_table: {
    sql: SELECT *, "Burning Crop Residues" as emission_type FROM `lookerdata.un_data.emissions_agriculture_burning_crop_residues`
          UNION ALL
          SELECT *, "Burning Savanna" as emission_type FROM `lookerdata.un_data.emissions_agriculture_burning_savanna`
          UNION ALL
          SELECT *, "Crop Residues" as type FROM `lookerdata.un_data.emissions_agriculture_crop_residues`
          UNION ALL
          SELECT *, "Cultivated Organic Soils" as emission_type FROM `lookerdata.un_data.emissions_agriculture_cultivated_organic_soils`
          UNION ALL
          SELECT *, "Energy Use" as emission_type FROM `lookerdata.un_data.emissions_agriculture_energy_use`
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

  dimension: emission_type {
    type: string
    sql: ${TABLE}.emission_type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

}
