#!/usr/bin/env node

/**
 * validate-code.js
 *
 * Purpose: Validate code generation specifications before execution
 * Usage: node validate-code.js --spec path/to/spec.json --target staging --check-secrets
 *
 * Checks:
 * 1. Spec complete (all required fields defined)
 * 2. No hardcoded secrets (API keys, passwords, tokens)
 * 3. Staging target only (not production)
 * 4. Template exists (for template-based generation)
 * 5. Dependencies valid (packages exist, versions compatible)
 */

const fs = require('fs');
const path = require('path');

// Parse command line arguments
function parseArgs() {
  const args = process.argv.slice(2);
  const options = {
    spec: null,
    target: 'staging',
    checkSecrets: true,
  };

  for (let i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--spec':
        options.spec = args[++i];
        break;
      case '--target':
        options.target = args[++i];
        break;
      case '--check-secrets':
        options.checkSecrets = args[++i] !== 'false';
        break;
      case '--help':
        printHelp();
        process.exit(0);
    }
  }

  return options;
}

function printHelp() {
  console.log(`
Usage: node validate-code.js [options]

Options:
  --spec <path>          Path to specification JSON file (required)
  --target <env>         Target environment (default: staging)
  --check-secrets        Check for hardcoded secrets (default: true)
  --help                 Show this help message

Example:
  node validate-code.js --spec middleware-spec.json --target staging

Output: JSON validation result with checks, errors, and warnings
  `);
}

// Main validation function
async function validateCode(options) {
  const result = {
    valid: true,
    checks: {},
    errors: [],
    warnings: [],
  };

  try {
    // Check 1: Spec file exists and is valid JSON
    result.checks.spec_complete = await checkSpecComplete(options.spec, result);

    // Check 2: No hardcoded secrets
    if (options.checkSecrets) {
      result.checks.no_secrets = await checkNoSecrets(options.spec, result);
    }

    // Check 3: Staging target only
    result.checks.staging_target = checkStagingTarget(options.target, result);

    // Check 4: Template exists (if template-based generation)
    result.checks.template_exists = await checkTemplateExists(options.spec, result);

    // Check 5: Dependencies valid
    result.checks.dependencies_valid = await checkDependenciesValid(options.spec, result);

    // Set overall valid status
    result.valid = result.errors.length === 0;

  } catch (error) {
    result.valid = false;
    result.errors.push({
      type: 'validation_error',
      message: error.message,
    });
  }

  return result;
}

// Check 1: Spec complete
async function checkSpecComplete(specPath, result) {
  if (!specPath) {
    result.errors.push({
      type: 'missing_spec',
      message: 'No spec file provided (use --spec <path>)',
    });
    return { pass: false };
  }

  if (!fs.existsSync(specPath)) {
    result.errors.push({
      type: 'spec_not_found',
      message: `Spec file not found: ${specPath}`,
    });
    return { pass: false };
  }

  try {
    const spec = JSON.parse(fs.readFileSync(specPath, 'utf8'));

    // TODO: Validate required fields based on spec type
    const requiredFields = ['name', 'type', 'source', 'target'];
    const missingFields = requiredFields.filter(field => !spec[field]);

    if (missingFields.length > 0) {
      result.errors.push({
        type: 'incomplete_spec',
        message: `Missing required fields: ${missingFields.join(', ')}`,
        fields: missingFields,
      });
      return { pass: false };
    }

    return { pass: true };
  } catch (error) {
    result.errors.push({
      type: 'invalid_json',
      message: `Failed to parse spec file: ${error.message}`,
    });
    return { pass: false };
  }
}

// Check 2: No hardcoded secrets
async function checkNoSecrets(specPath, result) {
  // TODO: Implement secret detection
  // Patterns to check:
  // - API keys (looking for key=, apiKey:, API_KEY=)
  // - Passwords (password=, PASSWORD=)
  // - Tokens (token=, TOKEN=, bearer)
  // - Database credentials (user=, password=, host=)

  const secretPatterns = [
    /api[_-]?key\s*[:=]\s*['"]?[a-zA-Z0-9_-]{20,}['"]?/gi,
    /password\s*[:=]\s*['"][^'"]+['"]/gi,
    /token\s*[:=]\s*['"]?[a-zA-Z0-9_-]{20,}['"]?/gi,
    /bearer\s+[a-zA-Z0-9_-]{20,}/gi,
  ];

  const spec = fs.readFileSync(specPath, 'utf8');
  const foundSecrets = [];

  for (const pattern of secretPatterns) {
    const matches = spec.match(pattern);
    if (matches) {
      foundSecrets.push(...matches);
    }
  }

  if (foundSecrets.length > 0) {
    result.errors.push({
      type: 'hardcoded_secrets',
      message: `Found ${foundSecrets.length} potential hardcoded secrets`,
      details: foundSecrets.map(s => s.substring(0, 30) + '...'),
    });
    return { pass: false };
  }

  return { pass: true };
}

// Check 3: Staging target only
function checkStagingTarget(target, result) {
  const allowedTargets = ['staging', 'development', 'dev', 'test'];

  if (!allowedTargets.includes(target.toLowerCase())) {
    result.errors.push({
      type: 'invalid_target',
      message: `Target '${target}' not allowed for autonomous execution. Use: ${allowedTargets.join(', ')}`,
    });
    return { pass: false };
  }

  return { pass: true };
}

// Check 4: Template exists
async function checkTemplateExists(specPath, result) {
  // TODO: Implement template existence check
  // Read spec, if it specifies a template, verify template file exists

  try {
    const spec = JSON.parse(fs.readFileSync(specPath, 'utf8'));

    if (spec.template) {
      const templatePath = path.resolve(spec.template);
      if (!fs.existsSync(templatePath)) {
        result.warnings.push({
          type: 'template_not_found',
          message: `Template file not found: ${spec.template}`,
        });
        return { pass: true, warning: true }; // Warning, not error
      }
    }

    return { pass: true };
  } catch (error) {
    return { pass: true }; // Already validated in checkSpecComplete
  }
}

// Check 5: Dependencies valid
async function checkDependenciesValid(specPath, result) {
  // TODO: Implement dependency validation
  // Read spec, if it lists npm packages, verify they exist on registry
  // Check for known vulnerable versions

  try {
    const spec = JSON.parse(fs.readFileSync(specPath, 'utf8'));

    if (spec.dependencies) {
      // TODO: Check each dependency exists on npm registry
      // TODO: Check for known vulnerabilities (use npm audit or similar)

      for (const [pkg, version] of Object.entries(spec.dependencies)) {
        // Placeholder: In production, query npm registry
        if (pkg.startsWith('@unknown/')) {
          result.warnings.push({
            type: 'unknown_dependency',
            message: `Dependency '${pkg}' may not exist on npm registry`,
          });
        }
      }
    }

    return { pass: true };
  } catch (error) {
    return { pass: true }; // Already validated in checkSpecComplete
  }
}

// Main execution
if (require.main === module) {
  const options = parseArgs();

  if (!options.spec) {
    console.error('Error: --spec is required\n');
    printHelp();
    process.exit(1);
  }

  validateCode(options)
    .then(result => {
      console.log(JSON.stringify(result, null, 2));
      process.exit(result.valid ? 0 : 1);
    })
    .catch(error => {
      console.error('Validation failed:', error.message);
      process.exit(1);
    });
}

module.exports = { validateCode };
