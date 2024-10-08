# Zinit Annex Hooks

Zinit Annex Hooks is an extension for the Zsh-Zinit framework that allows you to define and manage custom hooks for various stages of a plugin's lifecycle. This extension provides a flexible way to execute scripts or commands at specific points, such as cloning, pulling, loading, or initializing a plugin.

## Features

- **Custom Hooks**: Define custom scripts to be executed at different stages of a plugin's lifecycle.
- **Lifecycle Stages**: Supports hooks for `clone`, `pull`, `load`, and `init` stages.
- **Easy Integration**: Seamlessly integrates with the Zinit framework using ICE modifiers.

## Installation

To install the Zinit Annex Hooks extension, load it as a regular Zinit plugin using the following command:

```zsh
zinit light kuttor/zinit-annex-hooks 
