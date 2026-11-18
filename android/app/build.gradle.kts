plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.plugin.compose")
}

android {
    namespace = "com.example.dutifuldailydevotional"
    compileSdk = 37

    defaultConfig {
        applicationId = "com.example.dutifuldailydevotional"
        minSdk = 26
        targetSdk = 37
        versionCode = 1
        versionName = "1.0"
    }

    buildFeatures {
        compose = true
    }

    // One copy of the content for both platforms: the iOS app's JSON is packaged as Android assets.
    // Devotionals land at assets/Devotionals/<tradition>.json, full texts at assets/<source>/<work>.json.
    sourceSets {
        getByName("main") {
            assets.directories.add("../../Shared/Resources")
            assets.directories.add("../../DutifulDailyDevotional/Resources/Texts")
        }
    }
}

dependencies {
    implementation(platform("androidx.compose:compose-bom:2026.09.00"))
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.material:material-icons-core")
    implementation("androidx.activity:activity-compose:1.13.0")

    testImplementation("junit:junit:4.13.2")
    testImplementation("org.json:json:20240303") // android.jar only has stubs of org.json
}
