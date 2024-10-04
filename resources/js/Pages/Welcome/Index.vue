<script setup>
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
    <div class="min-h-screen bg-gradient-to-r from-white to-blue-100 relative overflow-y-auto">
        <!-- Side Text Section -->
        <div class="absolute right-0 top-0 h-full w-1/4 bg-blue-100">
            <h1
                class="text-8xl font-bold text-right text-blue-900 transform rotate-90 translate-x-1/2 translate-y-1/4"
            >
                HISYAM ALI WAFI
            </h1>
        </div>

        <!-- Content Section -->
        <div class="container mx-auto px-8 py-12 flex justify-between items-center min-h-screen">
            <!-- Left Content -->
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

            <!-- Image Section -->
            <div class="relative">
                <img
                    :src="profile.image1 ? profile.image1 : ''"
                    class="w-96 h-96 rounded-lg shadow-xl object-cover"
                    alt="Profile Picture"
                />
            </div>
        </div>

        <!-- Project Completed Section -->
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

        <!-- Top Left Button (Fixing Hidden Button) -->
        <button
            class="absolute top-4 left-4 bg-blue-600 text-white px-4 py-2 rounded-full"
        >
            Home
        </button>
    </div>
</template>

<style scoped>
.bg-gradient-to-r {
    background-image: linear-gradient(to right, #ffffff, #e0f2fe);
}

.absolute {
    position: absolute;
}

.rotate-90 {
    transform: rotate(90deg);
}

.container {
    overflow: visible;
}
</style>
