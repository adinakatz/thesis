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
          ) as x
          LEFT JOIN (SELECT (CASE WHEN clsr_short_name = 'United States' THEN 'United States of America'
                  WHEN clsr_short_name = 'Russia' THEN 'Russian Federation'
                  ELSE clsr_short_name
                  END) as clsr_short_name, browser
                  FROM `lookerdata.un_data.country`) as y ON x.area = y.clsr_short_name

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
    html: {{emissions_agriculture.country_with_flag._value}} ;;
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
    sql: ${TABLE}.browser ;;
  }

  dimension: country_with_flag {
    type: string
    sql: concat(${flag}, ' ', ${country}) ;;
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
#     link: {
#       label: "Livestock Production"
#       url: "/explore/un_data/production_combined?fields=production_combined.year,production_combined.sum_value,production_combined.item&pivots=production_combined.item&f[production_combined.year]={{emissions_agriculture.year._value | url_encode}}&f[production_combined.category]=Livestock&sorts=production_combined.year+desc,production_combined.sum_value+desc+0,production_combined.item&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%22stacking%22%3A%22%22%2C%22colors%22%3A%5B%22%23265780%22%2C%22%23D98541%22%2C%22%23C53DCC%22%2C%22%2333992E%22%2C%22%2336B38D%22%2C%22%23A2BF39%22%2C%22%235A3DCC%22%2C%22%238a0f3d%22%2C%22%23ff7aa3%22%2C%22%232d89bd%22%2C%22%238f09b0%22%2C%22%23d94141%22%5D%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22point_style%22%3A%22none%22%2C%22series_colors%22%3A%7B%7D%2C%22series_types%22%3A%7B%7D%2C%22limit_displayed_rows%22%3Afalse%2C%22hidden_series%22%3A%5B%22Beehives+-+production_combined.sum_value%22%2C%22Chickens+-+production_combined.sum_value%22%2C%22Ducks+-+production_combined.sum_value%22%2C%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22Turkeys+-+production_combined.sum_value%22%5D%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22left%22%2C%22series%22%3A%5B%7B%22id%22%3A%22Animals+live+nes+-+production_combined.sum_value%22%2C%22name%22%3A%22Animals+live+nes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Asses+-+production_combined.sum_value%22%2C%22name%22%3A%22Asses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Beehives+-+production_combined.sum_value%22%2C%22name%22%3A%22Beehives%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Buffaloes+-+production_combined.sum_value%22%2C%22name%22%3A%22Buffaloes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camelids%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Camelids%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camels+-+production_combined.sum_value%22%2C%22name%22%3A%22Camels%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Cattle+-+production_combined.sum_value%22%2C%22name%22%3A%22Cattle%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Chickens+-+production_combined.sum_value%22%2C%22name%22%3A%22Chickens%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Ducks+-+production_combined.sum_value%22%2C%22name%22%3A%22Ducks%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22name%22%3A%22Geese+and+guinea+fowls%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Goats+-+production_combined.sum_value%22%2C%22name%22%3A%22Goats%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Horses+-+production_combined.sum_value%22%2C%22name%22%3A%22Horses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Mules+-+production_combined.sum_value%22%2C%22name%22%3A%22Mules%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigeons%2C+other+birds%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigs+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigs%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22name%22%3A%22Rabbits+and+hares%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rodents%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Rodents%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Sheep+-+production_combined.sum_value%22%2C%22name%22%3A%22Sheep%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Turkeys+-+production_combined.sum_value%22%2C%22name%22%3A%22Turkeys%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22minValue%22%3A0%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22type%22%3A%22linear%22%7D%5D%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trend_lines%22%3A%5B%5D%2C%22show_null_points%22%3Afalse%2C%22interpolation%22%3A%22monotone%22%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%7D&filter_config=%7B%22production_combined.year%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222012%22%7D%2C%7B%22constant%22%3A%222012%22%7D%5D%2C%22id%22%3A7%2C%22error%22%3Afalse%2C%22variant%22%3A%22%5B%5D%22%7D%5D%2C%22production_combined.category%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22Livestock%22%7D%2C%7B%7D%5D%2C%22id%22%3A8%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%5D&origin=share-expanded"
#     }
  }

  measure: total_emissions_link {
    label: "Total Emissions"
    hidden: yes
    type: sum
    sql: ${TABLE}.value ;;
#     drill_fields: [emission_type, total_emissions]
    link: {
      label: "Livestock Production"
      url: "/explore/un_data/production_combined?fields=production_combined.year,production_combined.sum_value,production_combined.item&pivots=production_combined.item&f[production_combined.year]={{emissions_agriculture.year._value | url_encode}}&f[production_combined.category]=Livestock&sorts=production_combined.year+desc,production_combined.sum_value+desc+0,production_combined.item&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%22stacking%22%3A%22%22%2C%22colors%22%3A%5B%22%23265780%22%2C%22%23D98541%22%2C%22%23C53DCC%22%2C%22%2333992E%22%2C%22%2336B38D%22%2C%22%23A2BF39%22%2C%22%235A3DCC%22%2C%22%238a0f3d%22%2C%22%23ff7aa3%22%2C%22%232d89bd%22%2C%22%238f09b0%22%2C%22%23d94141%22%5D%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22point_style%22%3A%22none%22%2C%22series_colors%22%3A%7B%7D%2C%22series_types%22%3A%7B%7D%2C%22limit_displayed_rows%22%3Afalse%2C%22hidden_series%22%3A%5B%22Beehives+-+production_combined.sum_value%22%2C%22Chickens+-+production_combined.sum_value%22%2C%22Ducks+-+production_combined.sum_value%22%2C%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22Turkeys+-+production_combined.sum_value%22%5D%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22left%22%2C%22series%22%3A%5B%7B%22id%22%3A%22Animals+live+nes+-+production_combined.sum_value%22%2C%22name%22%3A%22Animals+live+nes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Asses+-+production_combined.sum_value%22%2C%22name%22%3A%22Asses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Beehives+-+production_combined.sum_value%22%2C%22name%22%3A%22Beehives%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Buffaloes+-+production_combined.sum_value%22%2C%22name%22%3A%22Buffaloes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camelids%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Camelids%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camels+-+production_combined.sum_value%22%2C%22name%22%3A%22Camels%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Cattle+-+production_combined.sum_value%22%2C%22name%22%3A%22Cattle%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Chickens+-+production_combined.sum_value%22%2C%22name%22%3A%22Chickens%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Ducks+-+production_combined.sum_value%22%2C%22name%22%3A%22Ducks%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22name%22%3A%22Geese+and+guinea+fowls%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Goats+-+production_combined.sum_value%22%2C%22name%22%3A%22Goats%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Horses+-+production_combined.sum_value%22%2C%22name%22%3A%22Horses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Mules+-+production_combined.sum_value%22%2C%22name%22%3A%22Mules%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigeons%2C+other+birds%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigs+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigs%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22name%22%3A%22Rabbits+and+hares%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rodents%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Rodents%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Sheep+-+production_combined.sum_value%22%2C%22name%22%3A%22Sheep%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Turkeys+-+production_combined.sum_value%22%2C%22name%22%3A%22Turkeys%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22minValue%22%3A0%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22type%22%3A%22linear%22%7D%5D%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trend_lines%22%3A%5B%5D%2C%22show_null_points%22%3Afalse%2C%22interpolation%22%3A%22monotone%22%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%7D&filter_config=%7B%22production_combined.year%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222012%22%7D%2C%7B%22constant%22%3A%222012%22%7D%5D%2C%22id%22%3A7%2C%22error%22%3Afalse%2C%22variant%22%3A%22%5B%5D%22%7D%5D%2C%22production_combined.category%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22Livestock%22%7D%2C%7B%7D%5D%2C%22id%22%3A8%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%5D&origin=share-expanded"
#       url: "/looks/1044?&f[production_combined.year]={{emissions_agriculture.year._value | url_encode}}"
      icon_url: "https://www.emojibase.com/resources/img/emojis/apple/1f404.png"
    }
  }

  measure: percent_of_total_emissions {
    type: number
    sql: ${total_emissions} / ${emissions_aggriculture_rank_dt.world_total_emissions} ;;
    value_format_name: percent_1
  }
}
