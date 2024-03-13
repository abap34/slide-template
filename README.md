# LT-Template

[![Build Slide and Deploy](https://github.com/abap34/LT-template/actions/workflows/build.yaml/badge.svg)](https://github.com/abap34/LT-template/actions/workflows/build.yaml)

Template repository for lightning talk with [Marp](https://marp.app/)

## Usage

1. Create a new repository by clicking "Use this template" button.
2. Allow GitHub Actions to build and deploy your slide.
   1. Go to `https://github.com/{username}/{repository-name}/settings/pages` and select `GitHub Actions` as source.
3. Write your slide in `slides` directory.
   1. To seperate slide to multiple files, create a `{number}_{title}.md` file in `slides` directory.
   2. Files are sorted by number and concatenated. For more datails, see "Warning" section.
4. Push to `main` branch.
5. Your slide will be published at `https://<username>.github.io/<repository-name>` !


## Customization

In this template, [honwaka-theme](https://github.com/abap34/honwaka-theme) is used as default theme. You can change the theme by editing `Makefile` and `.marprc.yml`.


1. Edit `Makefile`
   - Change `THEME_NAME`, `THEME_REPO` to your theme. 
2. Edit `.marprc.yml`
   - Change `theme` to your theme.

## Warning

- When you separate slide to multiple files, This template concatenate under below rules.
  - Files are sorted before concatenation by it's name. So, {number}_{title}.md is recommended. 
  - **YAML front matter is only adapted from the first file.**
    - The first file is expanded as is. Files after the first file are concatenated without YAML front matter.

