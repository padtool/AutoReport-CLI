
# ⚡ AutoReport CLI Engine

[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux-lightgrey.svg)](#)
[![Zero Dependencies](https://img.shields.io/badge/Dependencies-0-brightgreen.svg)](#)
[![Status](https://img.shields.io/badge/Status-Production_Ready-blue.svg)](#)

**AutoReport** is a lightweight, standalone Command Line Interface (CLI) utility designed to completely eliminate dependency bottlenecks when extracting data from large batches of PDF and DOCX files. 

Stop wrestling with complex Python libraries (`pdfplumber`, `PyPDF2`), broken Regex rules, and slow environment setups. Drop the binary into your server or local machine and get structured JSON payloads instantly.

## 🚀 Why AutoReport?
* **Zero-Setup:** Fully compiled standalone binary. No Python installation, no virtual environments, no `pip install` required.
* **100% Local Execution:** Total privacy. No API calls, no cloud processing. Air-gap ready.
* **Blazing Fast:** Iterates through massive folders of documents in seconds, bypassing the bloat of traditional parsers.
* **Structured Output:** Dumps targeted data (totals, emails, specific strings) directly into clean JSON.

## 📊 Benchmark
| Parser Method | Dependencies | Execution Environment | Speed |
| :--- | :--- | :--- | :--- |
| Python (`pdfminer`) | Heavy | `venv` / Host OS | Slow |
| Cloud API (AWS/GCP) | None | Requires Internet / High Latency | Medium |
| **AutoReport CLI** | **None** | **Native Binary (Local)** | **Ultra-Fast** |

## 📦 Installation & Download

This is commercial, proprietary software. The compiled, zero-dependency binaries for Windows and Linux are available for immediate download:

📥 **[Get AutoReport CLI - Windows Edition](https://payhip.com/b/n1LrH)** 📥 **[Get AutoReport CLI - Linux Edition](https://toolpad.gumroad.com/l/vpahtz)**

## 💻 Quick Start Example

```bash
# Simply call the executable and pass the target directory
./autoreport_engine --input /var/documents/batch_01 --extract "emails" --output data.json

# Expected Output in terminal:
# [SUCCESS] Parsed 450 documents in 1.2s. Output saved to data.json.
