# slide-template

[![Build Slide and Deploy](https://github.com/abap34/LT-template/actions/workflows/build.yaml/badge.svg)](https://github.com/abap34/LT-template/actions/workflows/build.yaml)

This is a template repository for creating slides with [Marp](https://marp.app/).

## Usage

1. Click the "Use this template" button to create a new repository.
2. Enable GitHub Actions to build and deploy your slide:
   - Navigate to `https://github.com/{username}/{repository-name}/settings/pages` and select `GitHub Actions` as the source.
3. Write your slide content in the `slides` directory:
   - To split your slide into multiple files, create `{number}_{title}.md` files in the `slides` directory.
   - Files are sorted numerically by number and then concatenated. See the "Warning" section for details.
   - Files under the `slides` directory will be copied to the `build` directory. Therefore, please place images and other assets here."
4. Push changes to the `main` branch.
5. Your slide will be published at `https://<username>.github.io/<repository-name>` 🤗

## Customize Theme

This template uses the [honwaka-theme](https://github.com/abap34/honwaka-theme) as the default theme. You can customize the theme by editing the `Makefile` and `.marprc.yml` files.

1. Edit `Makefile`:
   - Modify `THEME_NAME` and `THEME_REPO` according to your chosen theme.
2. Edit `.marprc.yml`:
   - Change the `theme` field to your desired theme.

## Build Slide Locally

1. Install the [Marp CLI](https://github.com/marp-team/marp-cli).
2. Run `make all` to build the slide in the `build/` directory:
   - This command generates `.html`, `.pdf`, and `.pptx` files. Individual targets like `make html`, `make pdf`, and `make pptx` are also available.
3. Use `make preview` to start a local server and open your slide in a browser for preview.

## Warning

When splitting slides into multiple files, follow these rules:

- Files are sorted before concatenation based on their names, so using `{number}_{title}.md` is recommended.
- **YAML front matter is only applied from the first file**:
  - The first file retains its YAML front matter. Subsequent files are concatenated without YAML front matter.
