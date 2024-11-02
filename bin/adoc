#!/usr/bin/env ruby
require 'asciidoctor-pdf'
require 'asciidoctor/extensions'

# argument parser
args = ARGV
input_file = nil
theme_file = nil
output_file = nil

def help
  puts "Convert asciidoc files to pdf using asiidoctor's ruby API"
  puts "                                                         "
  puts "Usage: asciidoc-tor.rb -i input.adoc [-o output.pdf] [-c theme.yml]"
  return
end

args.each_with_index do |arg, index|
  case arg
    when '-h'
      help
      exit
    when '-c'
      theme_file = args[index + 1] if index + 1 < args.length
    when '-i'
      input_file = args[index + 1] if index + 1 < args.length
    when '-o'
      output_file = args[index + 1] if index + 1 < args.length
  end
end

if input_file.nil?
  puts "Error: Input file is missing"
  exit
end

output_file ||= input_file.sub('.adoc', '.pdf')

# puts "Input file: #{input_file}"
# puts "Output file: #{output_file}"

settings = {
  font_main:	'LiberationSerif',
  font_title:	'LiberationSerif',
  font_code:	'UbuntuMono',
  # font_code:	'JetBrainsMono',
  # font_prepath: Dir.pwd,
  font_prepath: "/usr/share/fonts/truetype",
  font_prepath2: "/home/hossein/.local/share/fonts",
  font_size_main: 11.5,
  font_size_code: 10,
  font_size_inlinecode: 10,
  font_size_caption: 12.5,
  number: true,
  # cap_color: "#ff7700",
  # cap_color:	"#7a2518",
  # code_color:	"#25187a",
  doc_author: "Hos Es",
  doc_highlight: "pygments", # pygments, rouge
  doc_syntax: "solarized-dark", # pygments: algol, friendly_grayscale, bw; rouge: base16.solarized.light
  # doc_lang: "lua",
  doc_name: input_file,
  h_dlist: false,
}

# def lists
if settings[:h_dlist]
  Asciidoctor::Extensions.register do
      treeprocessor do
          process do |doc_name|
              (doc_name.find_by context: :dlist).each do |dlist|
                  dlist.style = 'horizontal'
              end
              nil
          end
      end
  end
end

# theme  

# colors {{{
colorscheme = {

  'github' => {
    background:   "#0d1117",
    text:         "#f0f6fc",
    title:        '#9198a1',
    link:         '#4493f8',
    dim:          "#232323",
    border:       "#9198a1",
    table_border: "#2f353d",
    table_bg_1:   "#151b23",
    table_bg_2:   "#0d1117",
    quote_text:   '#9198a1',
    quote_border: '#3d444d',
    sidebar:      '#151b23',
    code_bg:      '#1e242a',
    code_border:  '#3d444d',
    highlight:    '#f78166',
    note:         '#6a9e03',
    tip:          '#ffffff',
    caution:      '#9e0303',
    wanring:      '#9e6a03',
    important:    '#8957e5',
  },

  'dracula' => {
    background:   "#1e1f28",
    text:         "#f8f8f2",
    title:        '#bbbbbb',
    link:         '#8ae9fc',
    dim:          "#21262d",
    border:       "#8b949e",
    table_border: "#484f58",
    table_bg_1:   "#21262d",
    table_bg_2:   "#161b22",
    quote_text:   '#6e7681',
    quote_border: '#323543',
    sidebar:      '#000000',
    code_bg:      '#1e1f28',
    code_border:  '#545454',
    highlight:    '#f78166',
    note:         '#50fa7b',
    tip:          '#ffffff',
    caution:      '#ff5454',
    wanring:      '#f0fa8b',
    important:    '#bd92f8',
  },

  'solarized.dark' => {
    background:   "#001e26",
    text:         "#fdf6e3",
    title:        '#839496',
    link:         '#c61b6e',
    dim:          "#25292a",
    border:       "#839496",
    table_border: "#484f58",
    table_bg_1:   "#002731",
    table_bg_2:   "#073642",
    quote_text:   '#6e7681',
    quote_border: '#484f58',
    sidebar:      '#073642',
    code_bg:      '#002b36',
    code_border:  '#484f58',
    highlight:    '#2075c7',
    note:         '#728905',
    tip:          '#cccccc',
    caution:      '#d01b24',
    wanring:      '#a57705',
    important:    '#6c71c4',
  },

  'gruvbox.dark' => {
    background:   '#',
    text:         '#',
    title:        '#',
    link:         '#',
    dim:          '#',
    border:       '#',
    table_border: '#',
    table_bg_1:   '#',
    table_bg_2:   '#',
    quote_text:   '#',
    quote_border: '#',
    sidebar:      '#',
    code_bg:      '#',
    code_border:  '#',
    highlight:    '#',
    note:         '#',
    tip:          '#',
    caution:      '#',
    wanring:      '#',
    important:    '#',
  },

}
# }}}

body_theme = colorscheme['solarized.dark']

# list of fonts {{{
font_catalog = {
    'FreeSerif' => {
        normal:      '/home/hossein/.local/share/fonts/gnu-freefonts/serif/FreeSerif.ttf',
        bold:        '/home/hossein/.local/share/fonts/gnu-freefonts/serif/FreeSerifBold.ttf',
        italic:      '/home/hossein/.local/share/fonts/gnu-freefonts/serif/FreeSerifItalic.ttf',
        bold_italic: '/home/hossein/.local/share/fonts/gnu-freefonts/serif/FreeSerifBoldItalic.ttf',
    },
    'FreeSans' => {
        normal:      '/home/hossein/.local/share/fonts/gnu-freefonts/sans/FreeSans.ttf',
        bold:        '/home/hossein/.local/share/fonts/gnu-freefonts/sans/FreeSansBold.ttf',
        italic:      '/home/hossein/.local/share/fonts/gnu-freefonts/sans/FreeSansOblique.ttf',
        bold_italic: '/home/hossein/.local/share/fonts/gnu-freefonts/sans/FreeSansBoldOblique.ttf',
    },
    'FreeMono' => {
        normal:      '/home/hossein/.local/share/fonts/gnu-freefonts/mono/FreeMono.ttf',
        bold:        '/home/hossein/.local/share/fonts/gnu-freefonts/mono/FreeMonoBold.ttf',
        italic:      '/home/hossein/.local/share/fonts/gnu-freefonts/mono/FreeMonoOblique.ttf',
        bold_italic: '/home/hossein/.local/share/fonts/gnu-freefonts/mono/FreeMonoBoldOblique.ttf',
    },
    'LiberationSerif' => {
        normal:      settings[:font_prepath] + '/liberation/LiberationSerif-Regular.ttf',
        bold:        settings[:font_prepath] + '/liberation/LiberationSerif-Bold.ttf',
        italic:      settings[:font_prepath] + '/liberation/LiberationSerif-Italic.ttf',
        bold_italic: settings[:font_prepath] + '/liberation/LiberationSerif-BoldItalic.ttf',
    },
    'LiberationSans' => {
        normal:      settings[:font_prepath] + '/liberation/LiberationSans-Regular.ttf',
        bold:        settings[:font_prepath] + '/liberation/LiberationSans-Bold.ttf',
        italic:      settings[:font_prepath] + '/liberation/LiberationSans-Italic.ttf',
        bold_italic: settings[:font_prepath] + '/liberation/LiberationSans-BoldItalic.ttf',
    },
    'LiberationMono' => {
        normal:      settings[:font_prepath] + '/liberation/LiberationMono-Regular.ttf',
        bold:        settings[:font_prepath] + '/liberation/LiberationMono-Bold.ttf',
        italic:      settings[:font_prepath] + '/liberation/LiberationMono-Italic.ttf',
        bold_italic: settings[:font_prepath] + '/liberation/LiberationMono-BoldItalic.ttf',
    },
    'JetBrainsMono' => {
        normal:      settings[:font_prepath] + '/jetbrains/JetBrainsMono-Regular.ttf',
        bold:        settings[:font_prepath] + '/jetbrains/JetBrainsMono-Bold.ttf',
        italic:      settings[:font_prepath] + '/jetbrains/JetBrainsMono-Italic.ttf',
        bold_italic: settings[:font_prepath] + '/jetbrains/JetBrainsMono-BoldItalic.ttf',
    },
    'UbuntuMono' => {
        normal:      settings[:font_prepath] + '/ubuntu/UbuntuMono-R.ttf',
        bold:        settings[:font_prepath] + '/ubuntu/UbuntuMono-B.ttf',
        italic:      settings[:font_prepath] + '/ubuntu/UbuntuMono-RI.ttf',
        bold_italic: settings[:font_prepath] + '/ubuntu/UbuntuMono-BI.ttf',
    },
    'Ubuntu' => {
        bold:        settings[:font_prepath] + '/ubuntu/Ubuntu-B.ttf',
        normal:      settings[:font_prepath] + '/ubuntu/Ubuntu-R.ttf',
        italic:      settings[:font_prepath] + '/ubuntu/Ubuntu-RI.ttf',
        bold_italic: settings[:font_prepath] + '/ubuntu/Ubuntu-BI.ttf',
    },
    'CMUSerif' => {
        normal:      settings[:font_prepath2] + '/cmu/cmunrm.ttf',
        bold:        settings[:font_prepath2] + '/cmu/cmunbx.ttf',
        italic:      settings[:font_prepath2] + '/cmu/cmunti.ttf',
        bold_italic: settings[:font_prepath2] + '/cmu/cmunbi.ttf',
    },
    'CMUMono' => {
        normal:      settings[:font_prepath2] + '/cmu/cmuntt.ttf',
        bold:        settings[:font_prepath2] + '/cmu/cmuntb.ttf',
        italic:      settings[:font_prepath2] + '/cmu/cmunit.ttf',
        bold_italic: settings[:font_prepath2] + '/cmu/cmuntx.ttf',
    },
}

font_main = settings[:font_main]
font_title = settings[:font_title]
font_code = settings[:font_code]

current_font_main = font_catalog[font_main]
current_font_title = font_catalog[font_title]
current_font_code = font_catalog[font_code]
# }}}

# puts '---------------'
# puts current_font_main
# puts '---------------'
# puts current_font_title
# puts '---------------'
# puts current_font_code
# puts '---------------'

# puts '---------------'
# puts Dir.pwd
# puts '---------------'

# current_font_main.each { |x| puts x[1] }
# current_font_title.each { |x| puts x[1] }
# current_font_code.each { |x| puts x[1] }

# yaml {{{
theme_content = <<-YAML
extends: default
page:
  background-color: #{body_theme[:background]}
  size: a4paper
  # layout: portrait
  # margin: [0.75in, 1in, 0.75in, 1in]
font:
  catalog:
    Noto Serif:
      normal:      #{current_font_main[:normal]}
      bold:        #{current_font_main[:bold]}
      italic:      #{current_font_main[:italic]}
      bold_italic: #{current_font_main[:bold_italic]}
    M+ 1mn:
      normal:      #{current_font_code[:normal]}
      bold:        #{current_font_code[:bold]}
      italic:      #{current_font_code[:italic]}
      bold_italic: #{current_font_code[:bold_italic]}
    Title Sans:
      normal:      #{current_font_title[:normal]}
      bold:        #{current_font_title[:bold]}
      italic:      #{current_font_title[:italic]}
      bold_italic: #{current_font_title[:bold_italic]}
base:
  font-color: #{body_theme[:text]}
  color: #{body_theme[:background]}
  #font-family: #{settings[:font_main]}
  font-size: #{settings[:font_size_main]}
link:
  font-color: #{body_theme[:link]}
  # text-decoration: underline
  text-decoration-color: #{body_theme[:link]}
kbd:
  #font-family: #{settings[:font_code]}
button:
  #font-family: #{settings[:font_main]}
prose:
  text-indent-inner: 18
caption:
  font-color: #{body_theme[:title]}
  font-size: #{settings[:font_size_caption]}
  font-style: bold # bold_italic
code:
  #font-family: #{settings[:font_code]}
  font-size: #{settings[:font_size_code]}
example:
  background-color: #{body_theme[:dim]}
  border-radius: 0.5
  border-width: 0.0
codespan:
  #font-family: #{settings[:font_code]}
  font-size: #{settings[:font_size_inlinecode]}
  font-color: #{body_theme[:text]}
  border-color: #{body_theme[:border]}
  border-offset: 1.5
  border-radius: 1.5
  background-color: #{body_theme[:code_bg]}
code:
  background-color: #{body_theme[:code_bg]}
  border-color: #{body_theme[:code_border]}
  font-color: #{body_theme[:text]}
sidebar:
  background-color: #{body_theme[:sidebar]}
  border-color: #{body_theme[:border]}
  border-radius: 1.0
  border-width: 0.4
  title:
    font-color: #{body_theme[:text]}
quote:
  font-color: #{body_theme[:quote_text]} 
  border-color: #{body_theme[:quote_border]} 
  border-width: 0.0
table:
  background-color: #{body_theme[:table_bg_2]}
  border-color: #{body_theme[:table_border]}
  head:
    background-color: #{body_theme[:table_bg_2]}
  body:
    stripe-background-color: #{body_theme[:table_bg_1]}
admonition:
  column-rule-style: dashed
  border-style: double
  label:
    # font-color: #262626
  icon:
    note:
      stroke-color: #{body_theme[:note]}
    warning:
      stroke-color: #{body_theme[:wanring]}
    caution:
      stroke-color: #{body_theme[:caution]}
    important:
      stroke-color: #{body_theme[:important]}
    tip:
      stroke-color: #{body_theme[:tip]}
heading:
  font-color: #{body_theme[:text]}
  h1-font-family: "Title Sans"
  h2-font-family: "Title Sans"
  h3-font-family: "Title Sans"
  h4-font-family: "Title Sans"
  h5-font-family: "Title Sans"
  h6-font-family: "Title Sans"
  h1-font-size: floor($base_font_size * 2.6)
  h2-font-size: floor($base_font_size * 2.15)
  h3-font-size: round($base_font_size * 1.7)
  h4-font-size: $base_font_size_large
  h5-font-size: $base_font_size
  h6-font-size: $base_font_size_small
YAML

if theme_file.nil?
  theme_file_path = Dir.pwd+'/asciidoctor-theme.yml'
else
  theme_file_path = theme_file
end

File.open(theme_file_path, 'w') do |file|
  file.write(theme_content)
end
# }}}

# options 
options = {
    backend: 'pdf',
    safe: :unsafe,
    doctype: :article, 
    # imagesdir: "imagedir",
    # to_file: 'main.pdf',
    # sourcemap: false,
    # standalone: false,

    attributes: {
        # "imagesdir" => "images",
        "skip-front-matter" => true,
        "author" => settings[:doc_author],
        "icons" => "font",
        "icon-set" => "fi",
        "table-stripes" => "even",
        'toc' => false,
        'sectnums' => settings[:number],
        'linenums' => false,
        'source-highlighter' => settings[:doc_highlight],
        'pygments-style' => settings[:doc_syntax],
        'pdf-themedir' => '.',
        'pdf-theme' => theme_file_path,
    }
}

options[:to_file] = output_file

Asciidoctor.convert_file settings[:doc_name], **options

# File.delete(theme_file_path)

