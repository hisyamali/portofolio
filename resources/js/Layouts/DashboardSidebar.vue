<script setup>
import { ref, onMounted, onBeforeUnmount, computed } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';
import NavLinkSidebar from '@/Components/NavLinkSidebar.vue';

// get user authenticated
const user = usePage().props.auth.user;
const currentRoute = computed(() => usePage().url);
const rootRoute = computed(() => {
    const [path] = currentRoute.value.split('?');
    const parts = path.split('/').filter(Boolean);
    return parts.length > 0 ? `/${parts[0]}` : '/';
});

const openDropdowns = ref({});

const toggleDropdown = (menuName) => {
    openDropdowns.value[menuName] = !openDropdowns.value[menuName];
};

const isDropdownOpen = (menuName) => {
    return openDropdowns.value[menuName];
};
const menus = [
    {
        name: 'Profile',
        href: '/profiles',
        show: true,
        childs: null,
    },
    // {
    //     name: 'Upload Mutasi',
    //     href: '/mutations/cart',
    //     show: true,
    //     childs: null,
    // },
    // {
    //     name: 'Push Notif SIPLah',
    //     href: '/push-notif-siplah',
    //     show: true,
    //     childs: null,
    // },
    // {
    //     name: 'Rekonsel Mutasi',
    //     href: '/reconciles',
    //     roles: ['ops', 'finance'],
    //     show: true,
    //     childs: [
    //         {
    //             name: 'Rekonsel Mutasi',
    //             href: '/reconciles',
    //             roles: ['super_admin', 'ops', 'finance'],
    //         },
    //         {
    //             name: 'Rekonsel List',
    //             href: '/reconciles/items',
    //             roles: ['super_admin', 'ops', 'finance'],
    //         },
    //         {
    //             name: 'Double Transaksi',
    //             href: '/reconciles/list-double-transaction',
    //             roles: ['super_admin', 'ops', 'finance', 'qc'],
    //         },
    //     ],
    // },
];
</script>

<template>
    <div class="h-full overflow-y-auto px-3 pb-4" scroll-region>
        <ul class="space-y-2 py-2">
            <template v-for="menu in menus" :key="menu.href">
                <!-- NON CHILDS -->
                <li v-if="menu.childs === null">
                    <NavLinkSidebar
                        v-if="menu.show"
                        :href="menu.href"
                        :active="currentRoute == menu.href"
                    >
                        {{ menu.name }}
                    </NavLinkSidebar>
                </li>
                <!-- WITH CHILD -->
                <li v-else v-if="menu.show">
                    <button
                        type="button"
                        class="group flex w-full items-center rounded-lg p-2 text-base text-gray-900 transition duration-75 hover:bg-gray-100"
                        :aria-controls="`dropdown-${menu.name}`"
                        :data-collapse-toggle="`dropdown-${menu.name}`"
                        :class="
                            rootRoute == menu.href
                                ? 'bg-green-200 text-gray-900 hover:bg-green-100'
                                : ''
                        "
                        @click="toggleDropdown(menu.name)"
                    >
                        <svg
                            class="h-6 w-6 text-gray-800"
                            aria-hidden="true"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="currentColor"
                            viewBox="0 0 24 24"
                        >
                            <path
                                fill-rule="evenodd"
                                d="M6 5V4a1 1 0 1 1 2 0v1h3V4a1 1 0 1 1 2 0v1h3V4a1 1 0 1 1 2 0v1h1a2 2 0 0 1 2 2v2H3V7c0-1.1.9-2 2-2h1ZM3 19v-8h18v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2Zm5-6a1 1 0 1 0 0 2h8a1 1 0 1 0 0-2H8Z"
                                clip-rule="evenodd"
                            />
                        </svg>
                        <span
                            class="ms-3 flex-1 whitespace-nowrap text-left rtl:text-right"
                            >{{ menu.name }}</span
                        >
                        <svg
                            class="h-3 w-3"
                            aria-hidden="true"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 10 6"
                        >
                            <path
                                stroke="currentColor"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="m1 1 4 4 4-4"
                            />
                        </svg>
                    </button>
                    <ul
                        :id="`dropdown-${menu.name}`"
                        class="space-y-2 py-2"
                        :class="
                            isDropdownOpen(menu.name)
                                ? 'show'
                                : 'hidden' && rootRoute == menu.href
                                  ? 'show'
                                  : 'hidden'
                        "
                    >
                        <template
                            v-if="menu.show"
                            v-for="child in menu.childs"
                            :key="child.href"
                        >
                            <li>
                                <Link
                                    :href="child.href"
                                    :class="
                                        currentRoute == child.href
                                            ? 'bg-orange-200 text-gray-900 hover:bg-orange-100'
                                            : ''
                                    "
                                    class="group flex w-full items-center rounded-lg p-2 pl-11 text-gray-900 transition duration-75 hover:bg-gray-100"
                                    >{{ child.name }}
                                </Link>
                            </li>
                        </template>
                    </ul>
                </li>
            </template>
        </ul>
    </div>
</template>

<style scoped>
aside {
    transition: transform 0.3s ease-in-out;
}
</style>
