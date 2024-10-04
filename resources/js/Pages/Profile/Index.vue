<script setup>
import { ref, onMounted, reactive } from "vue";
import axios from "axios";
import DashboardLayout from "@/Layouts/DashboardLayout.vue";
import TextInput from "@/Components/TextInput.vue";
import TextArea from "@/Components/TextArea.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import InputError from "@/Components/InputError.vue";
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

const profiles = ref({});
const formData = ref({});
const getData = async () => {
    try {
        const response = await axios.get("/profiles/get-data");
        profiles.value = response.data.data;
        // Define the form data
        formData.value = {
            id: profiles.value?.id ? profiles.value.id : "",
            profession: profiles.value.profession ? profiles.value.profession : "",
            experience: profiles.value?.experience ? profiles.value.experience : "",
            year_experience: profiles.value?.year_experience ? profiles.value.year_experience : "",
            project: profiles.value?.project ? profiles.value.project : "",
            max_project: profiles.value?.max_project ? profiles.value.max_project : "",
            description: profiles.value?.description ? profiles.value.description : "",
            images1: null,
            images2: null,
            images3: null,
        };
    } catch (error) {
        console.error("Something went wrong:", error);
    }
}

// Handle file uploads
const handleFileUpload = (event, field) => {
    formData.value[field] = event.target.files[0];
};

// Submit the form using Axios
const submitForm = async () => {

    const payload = new FormData();
    payload.append("profession", formData.value.profession);
    payload.append("experience", formData.value.experience);
    payload.append("year_experience", formData.value.year_experience);
    payload.append("project", formData.value.project);
    payload.append("max_project", formData.value.max_project);
    payload.append("description", formData.value.description);

    if (formData.value.images1) {
        payload.append("images1", formData.value.images1);
    }
    if (formData.value.images2) {
        payload.append("images2", formData.value.images2);
    }
    if (formData.value.images3) {
        payload.append("images3", formData.value.images3);
    }

    try {
        const response = await axios.post("/profiles", payload, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        });

        // Handle success (e.g., reset form or show success message)
        toast.success(response.data.message);
    } catch (error) {
        if (error.response && error.response.data.errors) {
            // Set validation errors
            Object.keys(error.response.data.errors).forEach((field) => {
                errors.value[field] = error.response.data.errors[field][0];
            });
        } else {
            console.error("Something went wrong:", error);
        }
    }
};

const updateForm = async () => {

    const payload = new FormData();
    payload.append("id", formData.value.id);
    payload.append("profession", formData.value.profession);
    payload.append("experience", formData.value.experience);
    payload.append("year_experience", formData.value.year_experience);
    payload.append("project", formData.value.project);
    payload.append("max_project", formData.value.max_project);
    payload.append("description", formData.value.description);

    if (formData.value.images1) {
        payload.append("images1", formData.value.images1);
    }
    if (formData.value.images2) {
        payload.append("images2", formData.value.images2);
    }
    if (formData.value.images3) {
        payload.append("images3", formData.value.images3);
    }

    try {
        const response = await axios.post(`/profiles/update-profile/${profiles.value.id}`, payload,
        {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        });
        toast.success(response.data.message);
    } catch (error) {
        if (error.response && error.response.data.errors) {
            // Set validation errors
            Object.keys(error.response.data.errors).forEach((field) => {
                errors.value[field] = error.response.data.errors[field][0];
            });
        } else {
            console.error("Something went wrong:", error);
        }
    }
};

onMounted(() => {
    getData();
});
</script>

<template>
    <DashboardLayout>
        <div class="max-w-4xl mx-auto p-6 bg-white dark:bg-gray-500 shadow-lg rounded-lg">
            <h2 class="text-2xl font-bold mb-6">Update Profile</h2>
            <form @submit.prevent="profiles.value && profiles.value.id ? updateForm : submitForm">
                <!-- Profession Field -->
                <div class="mb-4">
                    <InputLabel for="profession" value="Profesi" />
                    <TextInput
                        id="profession"
                        :value="formData.profession"
                        type="text"
                        class="mt-1 block w-full"
                        v-model="formData.profession"
                        required
                        autofocus
                    />
                </div>

                <!-- Experience Field -->
                <div class="mb-4">
                    <InputLabel for="experience" value="Pengalaman" />
                    <TextInput
                        id="experience"
                        :value="formData.experience"
                        type="text"
                        class="mt-1 block w-full"
                        v-model="formData.experience"
                        required
                    />
                </div>

                <!-- Year Experience Field -->
                <div class="mb-4">
                    <InputLabel
                        for="year_experience"
                        value="Banyak Tahun Pengalaman"
                    />
                    <TextInput
                        id="year_experience"
                        :value="formData.year_experience"
                        type="number"
                        class="mt-1 block w-full"
                        v-model="formData.year_experience"
                        required
                    />
                </div>

                <!-- Project Field -->
                <div class="mb-4">
                    <InputLabel for="project" value="Project" />
                    <TextInput
                        id="project"
                        :value="formData.project"
                        type="text"
                        class="mt-1 block w-full"
                        v-model="formData.project"
                        required
                    />
                </div>

                <!-- Year Project Field -->
                <div class="mb-4">
                    <InputLabel for="max_project" value="Banyak Project" />
                    <TextInput
                        id="max_project"
                        :value="formData.max_project"
                        type="number"
                        class="mt-1 block w-full"
                        v-model="formData.max_project"
                        required
                    />
                </div>

                <!-- Description Field -->
                <div class="mb-4">
                    <InputLabel for="description" value="Deskripsi" />
                    <TextArea
                        id="description"
                        :value="formData.description"
                        class="mt-1 block w-full"
                        v-model="formData.description"
                        required
                    />
                </div>

                <!-- Image Fields -->
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-4">
                    <div>
                        <InputLabel for="images1" value="Image 1" />
                        <input
                            id="images1"
                            type="file"
                            accept="image/*"
                            class="mt-1 block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100 dark:text-gray-200"
                            @change="handleFileUpload($event, 'images1')"
                        />
                    </div>
                    <div>
                        <InputLabel for="images2" value="Image 2" />
                        <input
                            id="images2"
                            type="file"
                            accept="image/*"
                            class="mt-1 block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100 dark:text-gray-200"
                            @change="handleFileUpload($event, 'images2')"
                        />
                    </div>
                    <div>
                        <InputLabel for="images3" value="Image 3" />
                        <input
                            id="images3"
                            type="file"
                            accept="image/*"
                            class="mt-1 block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100 dark:text-gray-200"
                            @change="handleFileUpload($event, 'images3')"
                        />
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="flex justify-end mt-6">
                    <PrimaryButton
                        v-if="profiles.value && profiles.value.id"
                        type="submit"
                        :class="{ 'opacity-25': formData.processing }"
                        :disabled="formData.processing"
                    >
                        Simpan
                    </PrimaryButton>

                    <PrimaryButton
                        v-if="!profiles.value || !profiles.value.id"
                        @click.prevent="updateForm"
                        :class="{ 'opacity-25': formData.processing }"
                        :disabled="formData.processing"
                    >
                        Update
                    </PrimaryButton>
                </div>
            </form>
        </div>
    </DashboardLayout>
</template>
