library(tidyverse)
library(ggplot2)
library(ggpubr)

db <- read_csv("Player Shooting.csv")
player_shooting <- db |>
  filter(season >= 1997) |>
  select(season, player, percent_fga_from_x2p_range, percent_fga_from_x3p_range)

db <- read_csv("Player Totals.csv")
player_totals <- db |>
  filter(season >= 1997) |>
  select(season, player, x3p_percent, x2p_percent)

player_data <- player_shooting |>
  left_join(player_totals, by = c("player", "season"))

db <- read_csv("Team Stats Per Game.csv")
team_data <- db |>
  filter(season >= 1997) |>
  select(season, x3pa_per_game, x3p_percent, x2pa_per_game, x2p_percent, pts_per_game)

team_stats <- team_data |>
  mutate(era = case_when(
    season < 2000 ~ "1990s",
    season < 2010 ~ "2000s",
    TRUE ~ "2010s+"
  ))

p1 <- ggplot(team_stats, aes(x = x3pa_per_game, y = pts_per_game, color = era)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    title = "3-Point Attempts vs Points per Game",
    x = "3PA per Game", y = "Points per Game"
  ) +
  theme_minimal(base_size = 13)

p2 <- ggplot(team_stats, aes(x = x2pa_per_game, y = pts_per_game, color = era)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    title = "2-Point Attempts vs Points per Game",
    x = "2PA per Game", y = "Points per Game"
  ) +
  theme_minimal(base_size = 13)

ggarrange(p1, p2, nrow = 2, common.legend = TRUE, legend = "top")

# Clear trend: Teams w/ more 3pa and less 2pa, have more ppg.
# Score more, win more.

# season_summary <- player_data |>
#   group_by(season) |>
#   summarise(
#     avg_3pa_rate = mean(percent_fga_from_x3p_range, na.rm = TRUE),
#     avg_3p_pct = mean(x3p_percent, na.rm = TRUE)
#   )

# season_summary_long <- season_summary |>
#   pivot_longer(
#     cols = c(avg_3pa_rate, avg_3p_pct),
#     names_to = "metric",
#     values_to = "value"
#   ) |>
#   mutate(
#     metric_label = case_when(
#       metric == "avg_3pa_rate" ~ "% of FGA from 3-Point Range",
#       metric == "avg_3p_pct" ~ "3-Point FG%"
#     )
#   )

# ggplot(season_summary_long, aes(x = season, y = value, color = metric_label)) +
#   geom_line(size = 1.3) +
#   geom_point(size = 2.5) +
#   scale_color_manual(
#     values = c(
#       "% of FGA from 3-Point Range" = "#3498DB",
#       "3-Point FG%" = "#E74C3C"
#     ),
#     name = NULL
#   ) +
#   labs(
#     title = "Evolution of the 3-Point Shot in the NBA (1997–Present)",
#     x = "Season",
#     y = "Percentage (%)"
#   ) +
#   scale_y_continuous(labels = scales::label_percent(scale = 1)) +
#   theme_minimal(base_size = 13) +
#   theme(
#     plot.title = element_text(face = "bold", hjust = 0.5, size = 15),
#     legend.position = "top",
#     legend.text = element_text(size = 11)
#   )

# target_year <- 2025
# mean_for_year <- player_data |>
#   filter(season == target_year) |>
#   summarise(mean_value = mean(x3p_percent, na.rm = TRUE)) |>
#   pull(mean_value)
# print(mean_for_year)
# 40.87% - 19.26% = 21.61% difference in 3pa (2025-1997)
# 31.71% - 28.54% = 3.17% difference in 3pt pct (2025-1997)
# It's clear that 3pa have increased, but efficiency really hasn't. Why?

# season_summary <- player_data |>
#   group_by(season) |>
#   summarise(
#     avg_2pa_rate = mean(percent_fga_from_x2p_range, na.rm = TRUE),
#     avg_2p_pct = mean(x2p_percent, na.rm = TRUE)
#   )

# season_summary_long <- season_summary |>
#   pivot_longer(
#     cols = c(avg_2pa_rate, avg_2p_pct),
#     names_to = "metric",
#     values_to = "value"
#   ) |>
#   mutate(
#     metric_label = case_when(
#       metric == "avg_2pa_rate" ~ "% of FGA from 2-Point Range",
#       metric == "avg_2p_pct" ~ "2-Point FG%"
#     )
#   )

# ggplot(season_summary_long, aes(x = season, y = value, color = metric_label)) +
#   geom_line(size = 1.3) +
#   geom_point(size = 2.5) +
#   scale_color_manual(
#     values = c(
#       "% of FGA from 2-Point Range" = "#3498DB",
#       "2-Point FG%" = "#E74C3C"
#     ),
#     name = NULL
#   ) +
#   labs(
#     title = "Evolution of the 2-Point Shot in the NBA (1997–Present)",
#     x = "Season",
#     y = "Percentage (%)"
#   ) +
#   scale_y_continuous(labels = scales::label_percent(scale = 1)) +
#   theme_minimal(base_size = 13) +
#   theme(
#     plot.title = element_text(face = "bold", hjust = 0.5, size = 15),
#     legend.position = "top",
#     legend.text = element_text(size = 11)
#   )

# target_year <- 2025
# mean_for_year <- player_data |>
#   filter(season == target_year) |>
#   summarise(mean_value = mean(x2p_percent, na.rm = TRUE)) |>
#   pull(mean_value)
# print(mean_for_year)
# 80.74% - 59.13% = 21.61% difference in 2pa (1997-2025)
# 53.03% - 44.18% = 8.85% difference in 2pt pct (2025-1997)
# 2pa have dropped significantly, but efficiency has risen substantially. Why?

# team_stats <- team_data |>
#   group_by(season) |>
#   summarise(
#     exp_pts_3 = mean(x3p_percent * 3, na.rm = TRUE),
#     exp_pts_2 = mean(x2p_percent * 2, na.rm = TRUE)
#   ) |>
#   pivot_longer(cols = c(exp_pts_3, exp_pts_2),
#                names_to = "Shot_Type",
#                values_to = "Exp_Points")

# ggplot(team_stats, aes(x = season, y = Exp_Points, color = Shot_Type)) +
#   geom_line(linewidth = 1.2) +
#   geom_point(size = 2) +
#   scale_color_manual(values = c("exp_pts_2" = "#E74C3C", "exp_pts_3" = "#3498DB"),
#                      labels = c("2-Point Shot", "3-Point Shot")) +
#   labs(
#     title = "Expected Points per Shot (League Average by Season)",
#     x = "Season",
#     y = "Expected Points per Shot",
#     color = "Shot Type"
#   ) +
#   theme_minimal(base_size = 13) +
#   theme(
#     plot.title = element_text(face = "bold", hjust = 0.5, size = 14)
#   )

# target_year <- 1997
# mean_for_year <- team_data |>
#   filter(season == target_year) |>
#   summarise(mean_value = mean(x2p_percent * 2, na.rm = TRUE)) |>
#   pull(mean_value)
# print(mean_for_year)
# 1.08 - 1.08 ~ the same in EV of 3pt
# 1.09 - 0.96 = 0.13 difference in EV of 2pt (2025-1997)

# The 3pt has always been statistically better than the 2pt, until recent years.
# Teams now know how to adjust and once they know a team can shoot,
# they will willingly open up the 2pt more bc of how dangerous it is.
# (Joe Mazzulla mindset of reading the 2 on 1)