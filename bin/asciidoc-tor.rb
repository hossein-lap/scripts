#!/usr/bin/env ruby
require 'asciidoctor-pdf'
require 'asciidoctor/extensions'

# argument parser
args = ARGV
input_file = nil
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
      theme_file_path = args[index + 1] if index + 1 < args.length
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
  font_prepath: "/home/hos/.local/share",
  font_size_main: 11.5,
  font_size_code: 10,
  font_size_inlinecode: 10,
  font_size_caption: 12.5,
  number: true,
  # cap_color: "#ff7700",
  cap_color:	"#7a2518",
  code_color:	"#25187a",
  doc_author: "Hos Es",
  doc_syntax: "bw", # pygments: algol, friendly_grayscale; rouge: base16.solarized.light
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

# fonts settings

# list of fonts
font_catalog = {
    'FreeSerif' => {
        normal:      '/home/hos/.local/share/fonts/gnu-freefonts/serif/FreeSerif.ttf',
        bold:        '/home/hos/.local/share/fonts/gnu-freefonts/serif/FreeSerifBold.ttf',
        italic:      '/home/hos/.local/share/fonts/gnu-freefonts/serif/FreeSerifItalic.ttf',
        bold_italic: '/home/hos/.local/share/fonts/gnu-freefonts/serif/FreeSerifBoldItalic.ttf',
    },
    'FreeSans' => {
        normal:      '/home/hos/.local/share/fonts/gnu-freefonts/sans/FreeSans.ttf',
        bold:        '/home/hos/.local/share/fonts/gnu-freefonts/sans/FreeSansBold.ttf',
        italic:      '/home/hos/.local/share/fonts/gnu-freefonts/sans/FreeSansOblique.ttf',
        bold_italic: '/home/hos/.local/share/fonts/gnu-freefonts/sans/FreeSansBoldOblique.ttf',
    },
    'FreeMono' => {
        normal:      '/home/hos/.local/share/fonts/gnu-freefonts/mono/FreeMono.ttf',
        bold:        '/home/hos/.local/share/fonts/gnu-freefonts/mono/FreeMonoBold.ttf',
        italic:      '/home/hos/.local/share/fonts/gnu-freefonts/mono/FreeMonoOblique.ttf',
        bold_italic: '/home/hos/.local/share/fonts/gnu-freefonts/mono/FreeMonoBoldOblique.ttf',
    },
    'LiberationSerif' => {
        normal:      settings[:font_prepath] + '/fonts/liberation/LiberationSerif-Regular.ttf',
        bold:        settings[:font_prepath] + '/fonts/liberation/LiberationSerif-Bold.ttf',
        italic:      settings[:font_prepath] + '/fonts/liberation/LiberationSerif-Italic.ttf',
        bold_italic: settings[:font_prepath] + '/fonts/liberation/LiberationSerif-BoldItalic.ttf',
    },
    'LiberationSans' => {
        normal:      settings[:font_prepath] + '/fonts/liberation/LiberationSans-Regular.ttf',
        bold:        settings[:font_prepath] + '/fonts/liberation/LiberationSans-Bold.ttf',
        italic:      settings[:font_prepath] + '/fonts/liberation/LiberationSans-Italic.ttf',
        bold_italic: settings[:font_prepath] + '/fonts/liberation/LiberationSans-BoldItalic.ttf',
    },
    'LiberationMono' => {
        normal:      settings[:font_prepath] + '/fonts/liberation/LiberationMono-Regular.ttf',
        bold:        settings[:font_prepath] + '/fonts/liberation/LiberationMono-Bold.ttf',
        italic:      settings[:font_prepath] + '/fonts/liberation/LiberationMono-Italic.ttf',
        bold_italic: settings[:font_prepath] + '/fonts/liberation/LiberationMono-BoldItalic.ttf',
    },
    'JetBrainsMono' => {
        normal:      settings[:font_prepath] + '/fonts/jetbrains/JetBrainsMono-Regular.ttf',
        bold:        settings[:font_prepath] + '/fonts/jetbrains/JetBrainsMono-Bold.ttf',
        italic:      settings[:font_prepath] + '/fonts/jetbrains/JetBrainsMono-Italic.ttf',
        bold_italic: settings[:font_prepath] + '/fonts/jetbrains/JetBrainsMono-BoldItalic.ttf',
    },
    'UbuntuMono' => {
        normal:      settings[:font_prepath] + '/fonts/ubuntu/UbuntuMono-R.ttf',
        bold:        settings[:font_prepath] + '/fonts/ubuntu/UbuntuMono-B.ttf',
        italic:      settings[:font_prepath] + '/fonts/ubuntu/UbuntuMono-RI.ttf',
        bold_italic: settings[:font_prepath] + '/fonts/ubuntu/UbuntuMono-BI.ttf',
    },
    'Ubuntu' => {
        bold:        settings[:font_prepath] + '/fonts/ubuntu/Ubuntu-B.ttf',
        normal:      settings[:font_prepath] + '/fonts/ubuntu/Ubuntu-R.ttf',
        italic:      settings[:font_prepath] + '/fonts/ubuntu/Ubuntu-RI.ttf',
        bold_italic: settings[:font_prepath] + '/fonts/ubuntu/Ubuntu-BI.ttf',
    },
    'CMUSerif' => {
        normal:      '/usr/share/fonts/truetype/cmu/cmunrm.ttf',
        bold:        '/usr/share/fonts/truetype/cmu/cmunbx.ttf',
        italic:      '/usr/share/fonts/truetype/cmu/cmunti.ttf',
        bold_italic: '/usr/share/fonts/truetype/cmu/cmunbi.ttf',
    },
    'CMUMono' => {
        normal:      '/usr/share/fonts/truetype/cmu/cmuntt.ttf',
        bold:        '/usr/share/fonts/truetype/cmu/cmuntb.ttf',
        italic:      '/usr/share/fonts/truetype/cmu/cmunit.ttf',
        bold_italic: '/usr/share/fonts/truetype/cmu/cmuntx.ttf',
    },
}

font_main = settings[:font_main]
font_title = settings[:font_title]
font_code = settings[:font_code]
current_font_main = font_catalog[font_main]
current_font_title = font_catalog[font_title]
current_font_code = font_catalog[font_code]

# yaml
theme_content = <<-YAML
extends: default
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
  #font-family: #{settings[:font_main]}
  font-size: #{settings[:font_size_main]}
code:
  #font-family: #{settings[:font_code]}
  font-size: #{settings[:font_size_code]}
codespan:
  #font-family: #{settings[:font_code]}
  font-size: #{settings[:font_size_inlinecode]}
  font-color: #{settings[:code_color]}
kbd:
  #font-family: #{settings[:font_code]}
button:
  #font-family: #{settings[:font_main]}
caption:
  font-color: #{settings[:cap_color]}
  font-size: #{settings[:font_size_caption]}
  font-style: bold # bold_italic
heading:
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

if input_file.nil?
  theme_file_path = 'asciidoctor-theme.yml'
  File.open(theme_file_path, 'w') do |file|
    file.write(theme_content)
  end
end

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
        "imagesdir" => "images",
        "skip-front-matter" => true,
        "author" => settings[:doc_author],
        "icons" => "font",
        "icon-set" => "fi",
        'toc' => false,
        'sectnums' => settings[:number],
        'linenums' => false,
        'source-highlighter' => 'pygments',
        'pygments-style' => settings[:doc_syntax],
        # 'source-highlighter' => 'rouge',
        # 'rouge-style' => settings[:doc_syntax],
        'pdf-themedir' => '.',
        'pdf-theme' => theme_file_path,
    }
}

options[:to_file] = output_file

Asciidoctor.convert_file settings[:doc_name], **options

# File.delete(theme_file_path)

