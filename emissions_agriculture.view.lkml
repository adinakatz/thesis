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
#     html: {% if value == _filters['emissions_agriculture.country'] %}
#             <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{emissions_agriculture.country_with_flag._value}}</p>
#           {% else %}
#             {{emissions_agriculture.country_with_flag._value}}
#           {% endif %};;
  html: {{emissions_agriculture.country_with_flag._value}} ;;
    sql: ${TABLE}.area ;;
    map_layer_name: countries
    link: {
      label: "Country Dashboard"
      url: "/dashboards/233"
       icon_url: "https://banner2.kisspng.com/20180401/udq/kisspng-earth-globe-t-shirt-world-emoji-earth-globe-5ac11e101dbaa5.1475494715226055841218.jpg"
    }

    link: {
      label: "Wikipedia"
      url: "https://en.wikipedia.org/wiki/{{value}}"
      icon_url: "https://banner2.kisspng.com/20180510/kue/kisspng-wikipedia-logo-computer-icons-smooth-bending-technology-background-png-free-down-5af4a6207d0835.0131541215259827525121.jpg"
      }
  }

  dimension: country_formatted {
    html: <p style="color: green; font-size:100%"> {{emissions_agriculture.country_with_flag._value}} </p> ;;
    sql:  ${TABLE}.area;;

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
      url: "/explore/un_data/production_combined?fields=production_combined.year,production_combined.sum_value,production_combined.item&pivots=production_combined.item&f[production_combined.area]={{emissions_agriculture.country._value}}&f[production_combined.year]={{emissions_agriculture.year._value | url_encode}}&f[production_combined.category]=Livestock&sorts=production_combined.year+desc,production_combined.sum_value+desc+0,production_combined.item&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%22stacking%22%3A%22%22%2C%22colors%22%3A%5B%22%23265780%22%2C%22%23D98541%22%2C%22%23C53DCC%22%2C%22%2333992E%22%2C%22%2336B38D%22%2C%22%23A2BF39%22%2C%22%235A3DCC%22%2C%22%238a0f3d%22%2C%22%23ff7aa3%22%2C%22%232d89bd%22%2C%22%238f09b0%22%2C%22%23d94141%22%5D%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22point_style%22%3A%22none%22%2C%22series_colors%22%3A%7B%7D%2C%22series_types%22%3A%7B%7D%2C%22limit_displayed_rows%22%3Afalse%2C%22hidden_series%22%3A%5B%22Beehives+-+production_combined.sum_value%22%2C%22Chickens+-+production_combined.sum_value%22%2C%22Ducks+-+production_combined.sum_value%22%2C%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22Turkeys+-+production_combined.sum_value%22%5D%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22left%22%2C%22series%22%3A%5B%7B%22id%22%3A%22Animals+live+nes+-+production_combined.sum_value%22%2C%22name%22%3A%22Animals+live+nes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Asses+-+production_combined.sum_value%22%2C%22name%22%3A%22Asses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Beehives+-+production_combined.sum_value%22%2C%22name%22%3A%22Beehives%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Buffaloes+-+production_combined.sum_value%22%2C%22name%22%3A%22Buffaloes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camelids%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Camelids%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camels+-+production_combined.sum_value%22%2C%22name%22%3A%22Camels%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Cattle+-+production_combined.sum_value%22%2C%22name%22%3A%22Cattle%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Chickens+-+production_combined.sum_value%22%2C%22name%22%3A%22Chickens%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Ducks+-+production_combined.sum_value%22%2C%22name%22%3A%22Ducks%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22name%22%3A%22Geese+and+guinea+fowls%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Goats+-+production_combined.sum_value%22%2C%22name%22%3A%22Goats%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Horses+-+production_combined.sum_value%22%2C%22name%22%3A%22Horses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Mules+-+production_combined.sum_value%22%2C%22name%22%3A%22Mules%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigeons%2C+other+birds%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigs+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigs%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22name%22%3A%22Rabbits+and+hares%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rodents%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Rodents%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Sheep+-+production_combined.sum_value%22%2C%22name%22%3A%22Sheep%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Turkeys+-+production_combined.sum_value%22%2C%22name%22%3A%22Turkeys%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22minValue%22%3A0%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22type%22%3A%22linear%22%7D%5D%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trend_lines%22%3A%5B%5D%2C%22show_null_points%22%3Afalse%2C%22interpolation%22%3A%22monotone%22%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%7D&filter_config=%7B%22production_combined.year%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222012%22%7D%2C%7B%22constant%22%3A%222012%22%7D%5D%2C%22id%22%3A7%2C%22error%22%3Afalse%2C%22variant%22%3A%22%5B%5D%22%7D%5D%2C%22production_combined.category%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22Livestock%22%7D%2C%7B%7D%5D%2C%22id%22%3A8%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%5D&origin=share-expanded"
#       url: "/looks/1044?&f[production_combined.year]={{emissions_agriculture.year._value | url_encode}}"
      icon_url: "https://www.emojibase.com/resources/img/emojis/apple/1f404.png"
    }
    link: {
      label: "Livestock Processed Production"
      url: "/explore/un_data/production_combined?fields=production_combined.year,production_combined.sum_value,production_combined.item&pivots=production_combined.item&f[production_combined.area]={{emissions_agriculture.country._value}}&f[production_combined.year]={{emissions_agriculture.year._value | url_encode}}&f[production_combined.category]=Livestock+Processed&sorts=production_combined.year+desc,production_combined.sum_value+desc+0,production_combined.item&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%22stacking%22%3A%22%22%2C%22colors%22%3A%5B%22%23265780%22%2C%22%23D98541%22%2C%22%23C53DCC%22%2C%22%2333992E%22%2C%22%2336B38D%22%2C%22%23A2BF39%22%2C%22%235A3DCC%22%2C%22%238a0f3d%22%2C%22%23ff7aa3%22%2C%22%232d89bd%22%2C%22%238f09b0%22%2C%22%23d94141%22%5D%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22point_style%22%3A%22none%22%2C%22series_colors%22%3A%7B%7D%2C%22series_types%22%3A%7B%7D%2C%22limit_displayed_rows%22%3Afalse%2C%22hidden_series%22%3A%5B%22Beehives+-+production_combined.sum_value%22%2C%22Chickens+-+production_combined.sum_value%22%2C%22Ducks+-+production_combined.sum_value%22%2C%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22Turkeys+-+production_combined.sum_value%22%5D%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22left%22%2C%22series%22%3A%5B%7B%22id%22%3A%22Animals+live+nes+-+production_combined.sum_value%22%2C%22name%22%3A%22Animals+live+nes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Asses+-+production_combined.sum_value%22%2C%22name%22%3A%22Asses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Beehives+-+production_combined.sum_value%22%2C%22name%22%3A%22Beehives%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Buffaloes+-+production_combined.sum_value%22%2C%22name%22%3A%22Buffaloes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camelids%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Camelids%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camels+-+production_combined.sum_value%22%2C%22name%22%3A%22Camels%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Cattle+-+production_combined.sum_value%22%2C%22name%22%3A%22Cattle%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Chickens+-+production_combined.sum_value%22%2C%22name%22%3A%22Chickens%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Ducks+-+production_combined.sum_value%22%2C%22name%22%3A%22Ducks%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22name%22%3A%22Geese+and+guinea+fowls%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Goats+-+production_combined.sum_value%22%2C%22name%22%3A%22Goats%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Horses+-+production_combined.sum_value%22%2C%22name%22%3A%22Horses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Mules+-+production_combined.sum_value%22%2C%22name%22%3A%22Mules%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigeons%2C+other+birds%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigs+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigs%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22name%22%3A%22Rabbits+and+hares%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rodents%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Rodents%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Sheep+-+production_combined.sum_value%22%2C%22name%22%3A%22Sheep%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Turkeys+-+production_combined.sum_value%22%2C%22name%22%3A%22Turkeys%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22minValue%22%3A0%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22type%22%3A%22linear%22%7D%5D%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trend_lines%22%3A%5B%5D%2C%22show_null_points%22%3Afalse%2C%22interpolation%22%3A%22monotone%22%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%7D&filter_config=%7B%22production_combined.year%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222012%22%7D%2C%7B%22constant%22%3A%222012%22%7D%5D%2C%22id%22%3A7%2C%22error%22%3Afalse%2C%22variant%22%3A%22%5B%5D%22%7D%5D%2C%22production_combined.category%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22Livestock%22%7D%2C%7B%7D%5D%2C%22id%22%3A8%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%5D&origin=share-expanded"
      icon_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROgD8whY62aO0EASqkLVgMysjyADB4FPGNYdLodll41RYaFkwvyg"
      }
    link: {
      label: "Livestock Primary Production"
      url: "/explore/un_data/production_combined?fields=production_combined.year,production_combined.sum_value,production_combined.item&pivots=production_combined.item&f[production_combined.area]={{emissions_agriculture.country._value}}&f[production_combined.year]={{emissions_agriculture.year._value | url_encode}}&f[production_combined.category]=Livestock+Primary&sorts=production_combined.year+desc,production_combined.sum_value+desc+0,production_combined.item&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%22stacking%22%3A%22%22%2C%22colors%22%3A%5B%22%23265780%22%2C%22%23D98541%22%2C%22%23C53DCC%22%2C%22%2333992E%22%2C%22%2336B38D%22%2C%22%23A2BF39%22%2C%22%235A3DCC%22%2C%22%238a0f3d%22%2C%22%23ff7aa3%22%2C%22%232d89bd%22%2C%22%238f09b0%22%2C%22%23d94141%22%5D%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A25%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22point_style%22%3A%22none%22%2C%22series_colors%22%3A%7B%7D%2C%22series_types%22%3A%7B%7D%2C%22limit_displayed_rows%22%3Afalse%2C%22hidden_series%22%3A%5B%22Beehives+-+production_combined.sum_value%22%2C%22Chickens+-+production_combined.sum_value%22%2C%22Ducks+-+production_combined.sum_value%22%2C%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22Turkeys+-+production_combined.sum_value%22%5D%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22orientation%22%3A%22left%22%2C%22series%22%3A%5B%7B%22id%22%3A%22Animals+live+nes+-+production_combined.sum_value%22%2C%22name%22%3A%22Animals+live+nes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Asses+-+production_combined.sum_value%22%2C%22name%22%3A%22Asses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Beehives+-+production_combined.sum_value%22%2C%22name%22%3A%22Beehives%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Buffaloes+-+production_combined.sum_value%22%2C%22name%22%3A%22Buffaloes%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camelids%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Camelids%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Camels+-+production_combined.sum_value%22%2C%22name%22%3A%22Camels%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Cattle+-+production_combined.sum_value%22%2C%22name%22%3A%22Cattle%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Chickens+-+production_combined.sum_value%22%2C%22name%22%3A%22Chickens%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Ducks+-+production_combined.sum_value%22%2C%22name%22%3A%22Ducks%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Geese+and+guinea+fowls+-+production_combined.sum_value%22%2C%22name%22%3A%22Geese+and+guinea+fowls%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Goats+-+production_combined.sum_value%22%2C%22name%22%3A%22Goats%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Horses+-+production_combined.sum_value%22%2C%22name%22%3A%22Horses%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Mules+-+production_combined.sum_value%22%2C%22name%22%3A%22Mules%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigeons%2C+other+birds+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigeons%2C+other+birds%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Pigs+-+production_combined.sum_value%22%2C%22name%22%3A%22Pigs%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rabbits+and+hares+-+production_combined.sum_value%22%2C%22name%22%3A%22Rabbits+and+hares%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Rodents%2C+other+-+production_combined.sum_value%22%2C%22name%22%3A%22Rodents%2C+other%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Sheep+-+production_combined.sum_value%22%2C%22name%22%3A%22Sheep%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%2C%7B%22id%22%3A%22Turkeys+-+production_combined.sum_value%22%2C%22name%22%3A%22Turkeys%22%2C%22axisId%22%3A%22production_combined.sum_value%22%7D%5D%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22minValue%22%3A0%2C%22unpinAxis%22%3Afalse%2C%22tickDensity%22%3A%22default%22%2C%22type%22%3A%22linear%22%7D%5D%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trend_lines%22%3A%5B%5D%2C%22show_null_points%22%3Afalse%2C%22interpolation%22%3A%22monotone%22%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%7D&filter_config=%7B%22production_combined.year%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222012%22%7D%2C%7B%22constant%22%3A%222012%22%7D%5D%2C%22id%22%3A7%2C%22error%22%3Afalse%2C%22variant%22%3A%22%5B%5D%22%7D%5D%2C%22production_combined.category%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22Livestock%22%7D%2C%7B%7D%5D%2C%22id%22%3A8%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%5D&origin=share-expanded"
      icon_url: "data:image/jpeg;base64,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"
    }

 }

  measure: percent_of_total_emissions {
    type: number
    sql: ${total_emissions} / ${emissions_aggriculture_rank_dt.world_total_emissions} ;;
    value_format_name: percent_1
  }
}
