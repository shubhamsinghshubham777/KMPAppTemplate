import org.jetbrains.kotlin.gradle.targets.js.webpack.KotlinWebpackConfig

plugins {
    alias(libs.plugins.kotlinMultiplatform)
}

kotlin {
    js {
        browser {
            runTask {
                devServer = KotlinWebpackConfig.DevServer(
                    open = false,
                    port = 3000,
                    static = mutableListOf(
                        "${layout.buildDirectory.asFile.get()}/processedResources/js/main"
                    )
                )
            }
        }
        binaries.executable()
    }

    sourceSets {
        jsMain.dependencies {
            // Put your web/JS dependencies here
        }
        jsTest.dependencies {
            // Put your test dependencies here
        }
    }
}
