
#!/bin/bash

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root using sudo."
  exit 1
fi

# Variables (Verify SCAP_FILE matches the path to your extracted XML)
PROFILE="xccdf_org.ssgproject.content_profile_cis_level2_server"
SCAP_FILE="ssg-content/scap-security-guide-0.1.81/ssg-ubuntu2404-ds.xml"

# Create a timestamped directory to store all outputs together
OUTPUT_DIR="oscap_cis_level2_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"
echo "All files will be saved in: $OUTPUT_DIR/"

# ==============================================================================
# STEP 1: Pre-Remediation Evaluation
# ==============================================================================
echo "[1/4] Running initial evaluation..."
oscap xccdf eval --profile "$PROFILE" \
  --results "$OUTPUT_DIR/pre_remediation_results.xml" \
  --report "$OUTPUT_DIR/pre_remediation_report.html" \
  "$SCAP_FILE"
# Note: oscap exits with code 2 if rules fail. The script naturally continues.

# ==============================================================================
# STEP 2: Generate Remediation Script
# ==============================================================================
echo "[2/4] Generating remediation script..."
oscap xccdf generate fix --profile "$PROFILE" \
  --fix-type bash \
  --output "$OUTPUT_DIR/remediation.sh" \
  "$SCAP_FILE"

# ==============================================================================
# STEP 3: Run Remediation Script
# ==============================================================================
echo "[3/4] Executing remediation script..."
echo "(Note: This may take a while. Keep an eye out for AIDE initialization.)"
bash "$OUTPUT_DIR/remediation.sh"

# ==============================================================================
# STEP 4: Post-Remediation Evaluation
# ==============================================================================
echo "[4/4] Running post-remediation evaluation..."
oscap xccdf eval --profile "$PROFILE" \
  --results "$OUTPUT_DIR/post_remediation_results.xml" \
  --report "$OUTPUT_DIR/post_remediation_report.html" \
  "$SCAP_FILE"

echo "=============================================================================="
echo "Process Complete! Your files are located in: $OUTPUT_DIR/"
ls -lh "$OUTPUT_DIR"
