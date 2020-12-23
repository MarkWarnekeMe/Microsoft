package test

import (
	"fmt"
	"log"
	"math/rand"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

/**
	Creates a random name that is used for testing
	Create terraform options (similar to the terraform command line arguments), references a static test.vars, that contains the configuration for the test
	Moves provider.tf into the module (../)
	Runs terraform plan & terraform apply
	Moves provider.tf back
**/

func moveFile(oldLocation, newLocation string) {
	err := os.Rename(oldLocation, newLocation)
	if err != nil {
		log.Panic(err)
	}
}

func TestTerraform(t *testing.T) {

	terraformDir := "../"
	originalLocation := "provider.ci.tf"
	underTestLocation := strings.Join([]string{terraformDir, originalLocation}, "")

	expectedName := fmt.Sprintf("t%d", rand.Intn(9999))

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: terraformDir,

		VarFiles: []string{"./test/test.tfvars"},

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"name": expectedName,
			"tenant_id" : os.Getenv("ARM_TENANT_ID")
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: false,
	}

	// Remove provider at the end to test folder
	defer moveFile(underTestLocation, originalLocation)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// Move provider.tf to the terraformDir
	moveFile(originalLocation, underTestLocation)

	// For debugging
	terraform.InitAndPlan(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
}
