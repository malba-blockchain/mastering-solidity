/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  env: {
    STAGING_ALCHEMY_KEY: "https://eth-goerli.g.alchemy.com/v2/RvwRiRKxrWHq-BWvbHAYS8AG0in_Lvzi",
  },
};

module.exports = nextConfig
