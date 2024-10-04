<script setup>
import { ref, onMounted } from 'vue';
import { MoonIcon, SunIcon } from '@heroicons/vue/24/solid';
import DashboardSidebar from './DashboardSidebar.vue';
import { Link } from '@inertiajs/vue3';

const sidebarOpen = ref(false);
const isDarkMode = ref(false);

const toggleSidebar = () => {
    sidebarOpen.value = !sidebarOpen.value;
};

const closeSidebar = () => {
    sidebarOpen.value = false;
};

const toggleDarkMode = () => {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
        document.documentElement.classList.add('dark');
    } else {
        document.documentElement.classList.remove('dark');
    }
};

const userMenuOpen = ref(false);
const toggleUserMenu = () => {
    userMenuOpen.value = !userMenuOpen.value;
};

onMounted(() => {
    if (
        window.matchMedia &&
        window.matchMedia('(prefers-color-scheme: dark)').matches
    ) {
        isDarkMode.value = true;
        document.documentElement.classList.add('dark');
    }
});
</script>
<template>
    <div
        :class="{ dark: isDarkMode }"
        class="min-h-screen bg-gray-100 dark:bg-gray-800"
    >
        <nav
            class="fixed top-0 z-50 w-full border-b border-gray-200 bg-white dark:border-gray-600 dark:bg-gray-700"
        >
            <div class="px-3 py-3 lg:px-5 lg:pl-3">
                <div class="flex items-center justify-between">
                    <div
                        class="flex items-center justify-start rtl:justify-end"
                    >
                        <button
                            @click="toggleSidebar"
                            data-drawer-target="logo-sidebar"
                            aria-controls="logo-sidebar"
                            type="button"
                            class="inline-flex items-center rounded-lg p-2 text-sm text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600 sm:hidden"
                        >
                            <span class="sr-only">Open sidebar</span>
                            <svg
                                class="h-6 w-6"
                                aria-hidden="true"
                                fill="currentColor"
                                viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg"
                            >
                                <path
                                    clip-rule="evenodd"
                                    fill-rule="evenodd"
                                    d="M2 4.75A.75.75 0 012.75 4h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 4.75zm0 10.5a.75.75 0 01.75-.75h7.5a.75.75 0 010 1.5h-7.5a.75.75 0 01-.75-.75zM2 10a.75.75 0 01.75-.75h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 10z"
                                ></path>
                            </svg>
                        </button>
                        <a href="/dashboard" class="ms-2 flex md:me-24">
                            <img
                                src="#"
                                class="me-3 h-8"
                                alt="FlowBite Logo"
                            />
                            <span
                                class="self-center whitespace-nowrap text-xl font-semibold dark:text-white sm:text-2xl"
                                >Portofolio</span
                            >
                        </a>
                    </div>
                    <div class="flex items-center">
                        <button
                            @click="toggleDarkMode"
                            class="relative inline-flex h-8 w-16 items-center rounded-full border border-gray-300 bg-gray-200 transition duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 dark:border-gray-600 dark:bg-gray-800"
                        >
                            <span
                                :class="{
                                    'translate-x-8': isDarkMode,
                                    'translate-x-0': !isDarkMode,
                                }"
                                class="flex h-6 w-6 transform items-center justify-center rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out"
                            >
                                <template v-if="isDarkMode">
                                    <SunIcon class="h-4 w-4 text-yellow-500" />
                                </template>
                                <template v-else>
                                    <MoonIcon class="h-4 w-4 text-gray-800" />
                                </template>
                            </span>
                        </button>
                        <div class="ms-3 flex items-center">
                            <div>
                                <button
                                    @click="toggleUserMenu"
                                    type="button"
                                    class="flex rounded-full bg-gray-800 text-sm focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
                                    aria-expanded="false"
                                    data-dropdown-toggle="dropdown-user"
                                >
                                    <span class="sr-only">Open user menu</span>
                                    <img
                                        class="h-8 w-8 rounded-full"
                                        src="https://flowbite.com/docs/images/people/profile-picture-5.jpg"
                                        alt="user photo"
                                    />
                                </button>
                            </div>
                            <div
                                :class="{
                                    hidden: !userMenuOpen,
                                    block: userMenuOpen,
                                }"
                                class="z-100 absolute right-4 top-8 my-4 list-none divide-y divide-gray-100 rounded bg-white text-base shadow dark:divide-gray-600 dark:bg-gray-700"
                                id="dropdown-user"
                            >
                                <div class="px-4 py-3" role="none">
                                    <p
                                        class="text-sm text-gray-900 dark:text-white"
                                        role="none"
                                    >
                                        {{ $page.props.auth.user.name }}
                                    </p>
                                    <p
                                        class="truncate text-sm font-medium text-gray-900 dark:text-gray-300"
                                        role="none"
                                    >
                                        {{ $page.props.auth.user.email }}
                                    </p>
                                </div>
                                <ul class="py-1" role="none">
                                    <li>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem"
                                            >Dashboard</a
                                        >
                                    </li>
                                    <li>
                                        <a
                                            href="/profiles/edit-password"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem"
                                            >Settings</a
                                        >
                                    </li>
                                    <li>
                                        <Link
                                            href="/logout"
                                            method="post"
                                            as="button"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem"
                                            >Sign out</Link
                                        >
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Overlay -->
        <div
            @click="closeSidebar"
            :class="[
                'fixed inset-0 bg-black bg-opacity-50 transition-opacity lg:hidden',
                sidebarOpen ? 'opacity-100' : 'pointer-events-none opacity-0',
            ]"
        ></div>

        <aside
            id="logo-sidebar"
            :class="{
                '-translate-x-full': !sidebarOpen,
                'translate-x-0': sidebarOpen,
            }"
            class="fixed left-0 top-0 z-40 h-screen w-64 border-r border-gray-200 bg-white pt-20 transition-transform dark:border-gray-700 dark:bg-gray-700 sm:-translate-x-0"
            aria-label="Sidebar"
        >
            <DashboardSidebar />
        </aside>

        <div class="p-4 sm:ml-64">
            <main class="mt-14">
                <slot />
            </main>
        </div>
    </div>
</template>

<style>
.required:after {
    content: '*';
    color: rgb(255, 68, 68);
}
</style>
