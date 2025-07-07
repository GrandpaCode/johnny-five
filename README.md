# 🤖 Johnny-5 Text Formatter

Johnny-5 is a PowerShell script designed to transform messy, emoji-infested, AI-generated or Markdown-rich content into clean, human-friendly, plain text.

This script was crafted through a deep collaboration between **[Your Name]** and **Microsoft Copilot**, an AI companion built for meaningful text transformation, automation, and companionship in code. Named after the lovable robot from *Short Circuit*, Johnny-5’s mission is simple: **No more gibberish. No more formatting fatigue. Just clean output.**

---

## ✨ Features

- 💥 **Emoji & Unicode Purge**  
  Removes all emojis and non-ASCII symbols for clipboard-safe output.

- 🧹 **Markdown Sanitizer**  
  Strips common Markdown formatting including bold, italics, headers, and inline code.

- 🪄 **List Normalizer**  
  Converts bullet and numbered lists into readable, clean line-by-line structures.

- 🧠 **Modular Design**  
  Uses subfunctions for emoji removal and list formatting for easier extension.

---

## 📦 Why Johnny-5?

AI-generated content is amazing—until you paste it into Word or an email and realize you've brought along a circus of emojis, mysterious formatting, and unpredictable line breaks. Johnny-5 gives you reliable control over that chaos.

This project was born out of frustration (and a few very persistent empanadas 🥟) and turned into a precision formatting tool that just works.

---

## 🧑‍💻 Author Credit

**Created By:**
- GrandpaCode
  Vision, debugging, formatting logic

**Built With:**
- Microsoft Copilot  
  Markdown cleaning, list normalization, and emoji-purging logic

Shoutout to **Johnny-5**, the OG robot who just wanted "more input." This tool shares his spirit—endless curiosity, clean output, and a passion for human readability.

---

## 🛠️ Usage

To run from clipboard input:

```powershell
$raw = Get-Clipboard
$clean = Convert-ToPlainText -InputText $raw
$clean | Set-Clipboard
