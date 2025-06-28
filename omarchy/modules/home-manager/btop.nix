{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};
in {
  home.file = {
    ".config/btop/themes/${cfg.theme}.theme" = {
      text = ''
        # Theme: ${cfg.theme}
        # Generated from omarchy theme system

        # Main background, empty for terminal default, need to be empty if you want transparent background
        theme[main_bg]="${theme.background}"

        # Main text color
        theme[main_fg]="${theme.foreground}"

        # Title color for boxes
        theme[title]="${theme.foreground}"

        # Highlight color for keyboard shortcuts
        theme[hi_fg]="${theme.accent}"

        # Background color of selected item in processes box
        theme[selected_bg]="${theme.surface}"

        # Foreground color of selected item in processes box
        theme[selected_fg]="${theme.foreground}"

        # Color of inactive/disabled text
        theme[inactive_fg]="${theme.inactive}"

        # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
        theme[graph_text]="${theme.foreground}"

        # Background color of the percentage meters
        theme[meter_bg]="${theme.surface}"

        # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
        theme[proc_misc]="${theme.primary}"

        # CPU, Memory, Network, Proc box outline colors
        theme[cpu_box]="${theme.surface_variant}"
        theme[mem_box]="${theme.surface_variant}"
        theme[net_box]="${theme.surface_variant}"
        theme[proc_box]="${theme.surface_variant}"

        # Box divider line and small boxes line color
        theme[div_line]="${theme.surface_variant}"

        # Temperature graph colors (Green -> Yellow -> Red)
        theme[temp_start]="${theme.success}"
        theme[temp_mid]="${theme.warning}"
        theme[temp_end]="${theme.error}"

        # CPU graph colors
        theme[cpu_start]="${theme.success}"
        theme[cpu_mid]="${theme.warning}"
        theme[cpu_end]="${theme.error}"

        # Mem/Disk free meter
        theme[free_start]="${theme.primary}"
        theme[free_mid]="${theme.primary_variant}"
        theme[free_end]="${theme.accent}"

        # Mem/Disk cached meter
        theme[cached_start]="${theme.secondary}"
        theme[cached_mid]="${theme.primary}"
        theme[cached_end]="${theme.accent}"

        # Mem/Disk available meter
        theme[available_start]="${theme.success}"
        theme[available_mid]="${theme.info}"
        theme[available_end]="${theme.primary}"

        # Mem/Disk used meter
        theme[used_start]="${theme.warning}"
        theme[used_mid]="${theme.error}"
        theme[used_end]="${theme.red}"

        # Download graph colors
        theme[download_start]="${theme.success}"
        theme[download_mid]="${theme.primary}"
        theme[download_end]="${theme.accent}"

        # Upload graph colors
        theme[upload_start]="${theme.warning}"
        theme[upload_mid]="${theme.secondary}"
        theme[upload_end]="${theme.error}"
      '';
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = cfg.theme;
      theme_background = false;
      truecolor = true;
      force_tty = false;
      vim_keys = true;
      rounded_corners = true;
      graph_symbol = "braille";
      graph_symbol_cpu = "default";
      graph_symbol_mem = "default";
      graph_symbol_net = "default";
      graph_symbol_proc = "default";
      shown_boxes = "cpu mem net proc";
      update_ms = 2000;
      proc_sorting = "cpu lazy";
      proc_reversed = false;
      proc_tree = false;
      proc_colors = true;
      proc_gradient = false;
      proc_per_core = false;
      proc_mem_bytes = true;
      proc_cpu_graphs = true;
      proc_info_smaps = false;
      proc_left = false;
      cpu_graph_upper = "total";
      cpu_graph_lower = "total";
      cpu_invert_lower = true;
      cpu_single_graph = false;
      cpu_bottom = false;
      show_uptime = true;
      check_temp = true;
      cpu_sensor = "Auto";
      show_coretemp = true;
      cpu_core_map = "";
      temp_scale = "celsius";
      base_10_sizes = false;
      show_cpu_freq = true;
      clock_format = "%X";
      background_update = true;
      custom_cpu_name = "";
      disks_filter = "";
      mem_graphs = true;
      mem_below_net = false;
      zfs_arc_cached = true;
      show_swap = true;
      swap_disk = true;
      show_disks = true;
      only_physical = true;
      use_fstab = true;
      zfs_hide_datasets = false;
      disk_free_priv = false;
      show_io_stat = true;
      io_mode = false;
      io_graph_combined = false;
      io_graph_speeds = "";
      net_download = 100;
      net_upload = 100;
      net_auto = true;
      net_sync = true;
      net_iface = "";
      show_battery = true;
      selected_battery = "Auto";
      log_level = "WARNING";
    };
  };
}
