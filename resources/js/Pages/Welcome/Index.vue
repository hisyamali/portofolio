<script setup>
import HireMeSection from '@/Components/HireMeSection.vue';
import ProjectSection from '@/Components/ProjectSection.vue';
import ServiceSection from '@/Components/ServiceSection.vue';
import SkillSection from '@/Components/SkillSection.vue';
import { ref, onMounted, onUnmounted } from 'vue'

const showAdditionalText = ref(false)
let lastScrollY = 0 // Track the last scroll position

const handleScroll = () => {
  // Show additional text when the user scrolls down by 10px or more
  showAdditionalText.value = window.scrollY > 10

  lastScrollY = window.scrollY // Update last scroll position
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<template>
  <div
    class="relative from-white to-blue-100 sm:flex sm:justify-center sm:items-center min-h-screen"
    style="min-height: 100vh"
  >
    <!-- Image Section -->
    <div>
      <img
        src="/image/WhatsApp Image 2024-11-04 at 13.18.37_a7c04dd1 - Copy.jpg"
        alt="Web Developer"
        class="max-w-xs object-cover rounded-full transition-transform transform hover:scale-105 sm:scale-100 mt-8 sm:mt-0 ml-24 sm:ml-10"
      />
      <p class="text-3xl font-bold text-gray-800 pl-8 ml-8 sm:ml-0">HISYAM ALI WAFI</p>
    </div>
    <!-- Main Content Section -->
    <div class="flex items-center">
      <!-- Text Section -->
      <div class="ml-8 text-center transition-all duration-500">
        <h1 class="text-4xl font-bold text-gray-800 mb-4">Web Developer</h1>
        <!-- <button
        class="mt-4 px-6 py-2 bg-blue-600 text-white font-semibold rounded-full hover:bg-blue-700 transition"
        > -->
        <a
        href="https://api.whatsapp.com/send?phone=6289675623831&text=Halo,%20saya%20tertarik%20untuk%20membahas%20project."
        target="_blank"
        class="mt-6 px-6 py-2 border border-gray-800 text-gray-800 font-semibold rounded-2xl hover:bg-gray-800 hover:text-white transition"
        >
          Hire Me
        </a>
        <!-- </button> -->
        <div class="mt-4 text-gray-800">
          <p class="text-3xl font-bold">3+</p>
          <p>Tahun Pengalaman Sebagai Pengembang Web</p>
        </div>

        <!-- Additional Text for Scrolling -->
        <transition name="fade">
          <div v-if="showAdditionalText" class="mt-4 text-gray-800">
            <p class="text-3xl font-bold">20+</p>
            <p>Proyek Sudah Terselesaikan dengan Baik</p>
          </div>
        </transition>
      </div>
    </div>
  </div>

  <!-- Skills Section with Scroll Animation -->
  <SkillSection />

  <!-- Services Section with Scroll Animation -->
  <ServiceSection />

  <!-- Projects Section -->
  <ProjectSection />

  <!-- Hire Me Section -->
  <HireMeSection />
</template>

<style scoped>
/* Fade transition for smooth entry of additional text */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active in <2.1.8 */ {
  opacity: 0;
}

/* Initial state for hidden skill cards */
.opacity-0 {
  opacity: 0;
}
.opacity-100 {
  opacity: 1;
}
.translate-y-10 {
  transform: translateY(10px);
}
.translate-y-0 {
  transform: translateY(0);
}
</style>


<!-- <script setup>
import { ref, onMounted, onBeforeUnmount } from "vue";
import axios from "axios";

// Data profil yang diambil dari server
const profile = ref({});
// State untuk menampilkan atau menyembunyikan tulisan proyek selesai
const showCompleted = ref(false);

// Fungsi untuk mengambil data profil dari API
const getProfile = async () => {
    try {
        const response = await axios.get("/profiles/get-data");
        profile.value = response.data.data;
    } catch (error) {
        console.error("Error fetching profile data:", error);
    }
};

// Fungsi yang menangani event scroll untuk mengatur visibilitas tulisan
const handleScroll = () => {
    const scrollPosition = window.scrollY;
    // Nilai di mana tulisan proyek selesai akan muncul
    const triggerPosition = 500;
    showCompleted.value = scrollPosition >= triggerPosition;
};

// Menggunakan onMounted untuk memanggil API dan menambahkan event listener
onMounted(async () => {
    await getProfile(); // Mengambil data profil
    handleScroll(); // Cek posisi awal saat komponen pertama kali dimuat
    window.addEventListener("scroll", handleScroll); // Tambahkan event listener
});

// Menggunakan onBeforeUnmount untuk melepaskan event listener
onBeforeUnmount(() => {
    window.removeEventListener("scroll", handleScroll); // Lepas event listener
});
</script>

<template>
    <div class="min-h-screen bg-gray-100 relative overflow-y-auto">
        <div class="absolute right-0 top-0 h-full w-1/4 bg-blue-100">
            <h1
                class="text-4xl font-bold text-right text-blue-900 transform rotate-90 translate-x-1/2 translate-y-1/4"
                >
                HISYAM ALI WAFI
            </h1>
        </div>

        <div class="mx-auto px-8 py-12 flex justify-between items-center min-h-screen">
            <div class="w-1/2 space-y-4">
                <h1 class="text-6xl font-bold text-gray-800">{{ profile.profession }}</h1>
                <p class="text-xl font-medium text-gray-600">
                    {{ profile.year_experience }}+ Tahun Pengalaman Sebagai
                    {{ profile.experience }}
                </p>
                <button
                    class="px-8 py-4 bg-blue-600 text-white rounded-full hover:bg-blue-700 transition duration-300 ease-in-out"
                >
                    Hire Me
                </button>
            </div>

            <div class="relative">
                <img
                    :src="profile.image1 ? profile.image1 : ''"
                    class="w-96 h-96 rounded-lg shadow-xl object-cover"
                    alt="Profile Picture"
                />
            </div>
        </div>

        <div
            v-show="showCompleted"
            class="w-full text-center py-12 transition-opacity duration-1000 ease-in-out opacity-0"
            :class="{ 'opacity-100': showCompleted }"
        >
            <h2 class="text-4xl font-bold text-gray-800">
                {{ profile.project }}
            </h2>
            <p class="text-6xl font-bold text-blue-600 mt-4">
                {{ profile.max_project }}+
            </p>
        </div>

        <button
            class="absolute top-4 left-4 bg-blue-600 text-white px-4 py-2 rounded-full"
        >
            Home
        </button>
    </div>
</template>

<style scoped>
</style> -->
